import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/finish.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/functions.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/utils/firebase.dart';
import 'utils/functions.dart';

class chooseWinner extends StatefulWidget {
  final Player player;
  const chooseWinner({Key? key, required this.player}) : super(key: key);

  @override
  chooseWinnerState createState() {
    return chooseWinnerState();
  }
}

class chooseWinnerState extends State<chooseWinner> {
  var items = ['win', 'lose'];
  List<String> dropdownvalues = [];
  num pot = 0;

  @override
  Widget build(BuildContext context) {
    Player p = widget.player;

    return Scaffold(
        appBar: AppBar(title: Text("Party: " + p.partyCode)),
        body: Container(
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Are you the winner?"),
                smallButton(
                    context,
                    "Yes",
                    () => {
                          p.isWinner = true,
                          // addUser(p),
                          nextPage(context, finish(winner: true, player: p))
                        }),
                smallButton(
                    context,
                    "No",
                    () => {
                          p.isWinner = false,
                          // addUser(p),
                          nextPage(context, finish(winner: false, player: p))
                        })
              ],
            )));
  }
}
