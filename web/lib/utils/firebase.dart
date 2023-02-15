import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web/firebase_options.dart';
import 'package:web/models/playerInfo.dart';

Future<void> addUser(Player p) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .doc(p.name)
      .set(p.toJSON())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

// Future<QuerySnapshot> lookUpLobby(String partyCode) async {

//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   users
//       .where('partyCode', isEqualTo: partyCode)
//       .get()
//       .then((value) => print("User updated"))
//       .catchError((error) => print("Failed to update user: $error"));
// }
