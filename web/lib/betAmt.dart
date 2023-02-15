import 'package:flutter/material.dart';

import 'package:web/models/playerInfo.dart';

/*
TODO:
- use stream of snapshot
- party = users who has the same partycode
- no loading screen, just end game button,
- users have option to change their bet during game
- users can see the names and bets of other players in the match 
*/

class betLobby extends StatefulWidget {
  final Player player;
  const betLobby({Key? key, required this.player}) : super(key: key);

  @override
  betLobbyState createState() {
    return betLobbyState();
  }
}

class betLobbyState extends State<betLobby> {
  @override
  Widget build(BuildContext context) {
    Player p = widget.player;

    return Scaffold(body: Container());
  }
}
