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

class inGame extends StatefulWidget {
  final String arg;
  const inGame({Key? key, required this.arg}) : super(key: key);

  @override
  inGameState createState() {
    return inGameState();
  }
}

class inGameState extends State<inGame> {
  @override
  Widget build(BuildContext context) {
    String partyCode = widget.arg.split('_')[0];
    String name = widget.arg.split('_')[1];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text.rich(TextSpan(children: [
        WidgetSpan(
          child: Icon(Icons.ios_share),
        ),
        TextSpan(
            text:
                "     Bet on this match with me at Centify.Games! Code: ${partyCode}"),
      ]))),
      body: theContainer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Game in progress..."),
              CircularProgressIndicator(),
              smallButton(context, "End?", () => null)
            ],
          )),
    );
  }
}
