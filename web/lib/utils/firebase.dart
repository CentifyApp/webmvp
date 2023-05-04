import 'dart:async';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web/models/playerInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:web/globals.dart' as globals;
import 'dart:html' as html;

final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> makePayment(String uid, int betAmt) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentReference docRef = await db
      .collection('customers')
      .doc(uid) //hardcoded for now, need to get uid
      .collection("checkout_sessions")
      .add({
    "mode": "payment",
    "price": globals.prices[betAmt],
    "success_url":
        "http://centify.games/#/lobby/${globals.player.partyCode}_${globals.player.name}",
    "cancel_url":
        "http://centify.games/#/lobby/${globals.player.partyCode}_${globals.player.name}" // One-time price created in Stripe // figure out pop up tab for payment,
  });
  return docRef.id;
}

Future<void> addUser(Player p) async {
  CollectionReference partyPlayers = FirebaseFirestore.instance
      .collection('parties')
      .doc(p.partyCode)
      .collection("players");
  partyPlayers
      .doc(p.name)
      .set(p.toJSON())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

void createLobby(String partyCode) {
  CollectionReference lobbies =
      FirebaseFirestore.instance.collection("parties");
  lobbies.doc(partyCode).set({"partyCode": partyCode});
  lobbies.doc(partyCode).collection("players").doc().set({});
}

void setBetAmt(String betAmount, String partyCode) {
  num betnum = num.parse(betAmount);
  CollectionReference lobbies =
      FirebaseFirestore.instance.collection("parties");
  lobbies.doc(partyCode).update({"betAmount": betnum});
}

void setPlayerWin(String partyCode, String name, bool win) {
  CollectionReference lobbies =
      FirebaseFirestore.instance.collection("parties");
  lobbies
      .doc(partyCode)
      .collection('players')
      .doc(name)
      .update({"isWinner": win});
}

void setPartyWinner(String partyCode, String name) {
  CollectionReference lobbies =
      FirebaseFirestore.instance.collection("parties");
  lobbies.doc(partyCode).update({"winner": name});
}

void removePlayer(Player p) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(p.name).delete();
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '270397286111-ubpfahhaoctnaieo2eehdf3ragm9qf64.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<UserCredential> GoogleSignUp(BuildContext context) async {
  // Trigger the authentication flow
  _signInSilently();

  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void _signInSilently() {
  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    print("user changed");
  });

  _googleSignIn.signInSilently();
}

Future<String> getUid(String partyCode, String name) async {
  String uid = '';

  await FirebaseFirestore.instance
      .collection('parties')
      .doc(partyCode)
      .collection('players')
      .doc(name)
      .get()
      .then((DocumentSnapshot docsnap) {
    if (docsnap.exists) {
      uid = docsnap.get('useruid');
    }
  });

  return uid;
}

Future<void> setGlobalPlayer(String partyCode, String name) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  await db
      .collection('parties')
      .doc(partyCode)
      .collection('players')
      .doc(name)
      .get()
      .then((DocumentSnapshot docsnap) {
    if (docsnap.exists) {
      globals.player = Player.fromJSON(docsnap.data() as Map<String, dynamic>);
    }
  });
}

Future<Player> getPlayer(String partyCode, String name) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Player p = Player();
  await db
      .collection('parties')
      .doc(partyCode)
      .collection('players')
      .doc(name)
      .get()
      .then((DocumentSnapshot docsnap) {
    if (docsnap.exists) {
      p = Player.fromJSON(docsnap.data() as Map<String, dynamic>);
    }
  });
  return p;
}

Future<void> deletePayment(String partyCode, String name) async {
  String uid = await getUid(partyCode, name);
  await FirebaseFirestore.instance
      .collection('customers')
      .doc(uid)
      .collection('payments')
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  });
  print('${uid} deleted');
}

Future<Widget> returnLobby(
    BuildContext context, String partyCode, String name) async {
  await setGlobalPlayer(partyCode, name);
  String uid = globals.player.useruid;
  FirebaseFirestore db = FirebaseFirestore.instance;
  await db
      .collection('customers')
      .doc(uid)
      .collection('payments')
      .snapshots()
      .listen((querySnapshot) {
    querySnapshot.docChanges.forEach((element) async {
      if (element.doc.data()!['status'] == 'succeeded' &&
          globals.player.bet == 0) {
        print(element.doc.data());
        globals.player.bet = element.doc.data()!['amount_received'] / 100;
        globals.player.ready = true;
        await addUser(globals.player);
        await deletePayment(globals.player.partyCode, globals.player.name);
      }
    });
  });

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('parties')
          .doc(partyCode)
          .collection('players')
          .where('partyCode', isEqualTo: partyCode)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.requireData;

        return SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: 500,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    trailing: Text(
                        'Bet: \$' + data.docs[index].data()['bet'].toString()),
                    title: Text(data.docs[index].data()['name']),
                  );
                }),
          ),
        );
      }));
}

Widget paymentButtonToNextPage(
    BuildContext context, String party, String name, int _price) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('parties')
          .doc(party)
          .collection('players')
          .doc(name)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final data = snapshot.requireData;
        if (!data.data()!['ready']) {
          return TextButton(
              onPressed: () async {
                String uid = await getUid(party, name);
                String docID = await makePayment(
                  uid,
                  _price,
                ); //update functions does not work
                FirebaseFirestore.instance
                    .collection('customers')
                    .doc(uid)
                    .collection('checkout_sessions')
                    .doc(docID)
                    .snapshots()
                    .listen((querysnapshot) {
                  final data = querysnapshot.data()!;
                  if (data.containsKey('sessionId') &&
                      data.containsKey('url')) {
                    html.window.location.href = data['url'] as String;
                  }
                });
              },
              child: Text("Make Payment"));
        } else {
          return TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/inGame/${party}_${name}',
                    arguments: '${party}_${name}');
              },
              child: Text("Start Game"));
        }
      }));
}
