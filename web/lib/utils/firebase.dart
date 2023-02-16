import 'package:web/choosewinner.dart';
import 'package:web/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';

Future<void> addUser(Player p) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .doc(p.name)
      .set(p.toJSON())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

// bool lobbyExists(String partyCode) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   var doc = users.where('partyCode', arrayContains: partyCode);
//   if(doc.get().)
//   });
// }

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

Widget lookUpLobby(BuildContext context, String partyCode) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('partyCode', isEqualTo: partyCode)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final data = snapshot.requireData;

        return SizedBox(
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
        );
      }));
}

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
