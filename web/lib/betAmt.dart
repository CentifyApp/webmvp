import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/utils/firebase.dart';

/*
TODO:
------How to check if they have venmoed??
 ---Check by hand manually 
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
    bool betSet = false;
    TextEditingController pBet = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Party: " + p.partyCode)),
      body: Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Bet Amount?"),
            formFieldText("in dollars", pBet),
            smallButton(
                context,
                'Confirm',
                () => {
                      if (RegExp(r'^[0-9]+$').hasMatch(pBet.text) && !betSet)
                        {
                          p.bet = num.parse(pBet.text),
                          addUser(p),
                          betSet = true
                        }
                      else
                        {
                          if (betSet)
                            {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Bet has already been set'),
                                        content: Text(
                                            'Please complete venmo request'),
                                      ))
                            }
                          else
                            {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Please check bet amount'),
                                        content:
                                            Text('Bet amount contains letters'),
                                      ))
                            }
                        }
                    })
          ],
        ),
        checkCompleteVenmo(context, p),
        lookUpLobby(context, p.partyCode),
      ])),
    );
  }
}
