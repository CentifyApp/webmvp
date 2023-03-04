import 'dart:async';

import 'package:web/choosewinner.dart';
import 'package:web/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

Future<void> addUser(Player p, String partyCode) async {
  CollectionReference partyPlayers = FirebaseFirestore.instance
      .collection('parties')
      .doc(partyCode)
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

void getPot(Player p) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  num pot = 0;
  String out = "";

  users.where('partyCode', isEqualTo: p.partyCode).get().then((value) => {
        for (var doc in value.docs) {pot += doc.get('bet')},
        sendEmail(p, pot.toString()),
        out = pot.toString()
      });
}

void removePlayer(Player p) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(p.name).delete();
}

// Future<bool> checkPartyExists(String partyCode) async {
//   var lobby = FirebaseFirestore.instance.collection('lobbies').doc(partyCode);
//   var doc = await lobby.get();
//   bool exists = false;
//   if (doc.exists) {
//     exists = true;
//     print("true");
//   }
//   return exists;
// }

Widget returnLobby(BuildContext context, String partyCode) {
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

        return Container(
          width: 500,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length < 4
                  ? snapshot.data!.docs.length
                  : 4,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  trailing: Text(
                      'Bet: \$' + data.docs[index].data()['bet'].toString()),
                  title: Text(data.docs[index].data()['name']),
                );
              }),
        );
      }));
}

Widget checkCompleteVenmo(BuildContext context, Player player) {
  bool betFinal = true;

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('partyCode', isEqualTo: player.partyCode)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final data = snapshot.requireData;

        for (var doc in data.docs) {
          if (doc.data()['bet'] == 0) {
            betFinal = false;
          }

          if (!doc.data()['ready']) {
            return smallButton(
                context,
                "In Game",
                () => {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Please complete venmo request'),
                                content: Text(
                                    'One or more players has not completed venmo request'),
                              ))
                    });
          }
        }

        return smallButton(context, "Finish Game",
            () => {nextPage(context, chooseWinner(player: player))});
      }));
}



// bool lobbyExists(String partyCode) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   var doc = users.where('partyCode', arrayContains: partyCode);
//   if(doc.get().)
//   });
// }

// Widget winnerRadio(BuildContext context, String partyCode) {
//   return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('partyCode', isEqualTo: partyCode)
//           .snapshots(),
//       builder: ((context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         final data = snapshot.requireData;

//         return SizedBox(
//           width: 500,
//           child: ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, int index) {
//                 String _winnerName = data.docs[0].data()['name'];

//                 return RadioListTile(
//                     value: data.docs[index].data()['name'],
//                     groupValue: _winnerName,
//                     onChanged: (value) => {
//                       _winnerName = value
//                     });
//               }),
//         );
//       }));
// }

