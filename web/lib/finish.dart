import 'dart:async';
import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web/main.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/functions.dart';
import 'models/playerInfo.dart';
import 'package:web/utils/firebase.dart';

class finish extends StatefulWidget {
  final bool winner;
  final Player player;

  const finish({Key? key, required this.winner, required this.player})
      : super(key: key);

  @override
  finishState createState() {
    return finishState();
  }
}

class finishState extends State<finish> {
  String pot = "";

  @override
  void initState() {
    if (widget.winner) {
      widget.player.isWinner = true;
      addUser(widget.player);
      getPot(widget.player);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Player p = widget.player;
    bool winner = widget.winner;

    if (winner) {
      removePlayer(p);
      return Scaffold(
          appBar: AppBar(title: Text("Party: " + p.partyCode)),
          body: Container(
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Congrats, you won!"),
                    Text(pot),
                  ],
                ),
                Text("Your rewards will arrive shortly"),
                bigButton(
                    context, "Play Again", () => nextPage(context, MyApp()))
              ],
            ),
          ));
    } else {
      removePlayer(p);
      return Scaffold(
          appBar: AppBar(title: Text("Party: " + p.partyCode)),
          body: Container(
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Better Luck next time!"),
                bigButton(
                    context, "Play Again", () => nextPage(context, MyApp()))
              ],
            ),
          ));
    }
  }
}
