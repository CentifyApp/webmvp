import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/utils/firebase.dart';

class betLobby extends StatefulWidget {
  final String partyCode;
  final Player player;

  const betLobby({Key? key, required this.partyCode, required this.player})
      : super(key: key);

  @override
  betLobbyState createState() {
    return betLobbyState();
  }
}

int betAmt = 0;

class betLobbyState extends State<betLobby> {
  @override
  Widget build(BuildContext context) {
    String party = widget.partyCode;
    Player p = widget.player;
    bool betSet = false;
    TextEditingController pBet = TextEditingController();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text("Party: " + party)),
        body: theContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                returnLobby(context, party),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: SizedBox(
                        width: 500,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Place your bets!"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            setState(() {
                                              betAmt <= 0
                                                  ? betAmt = 0
                                                  : betAmt--;
                                            })
                                          },
                                      icon: Icon(Icons.remove_circle_outline)),
                                  Text("\$" + betAmt.toString()),
                                  IconButton(
                                      onPressed: () => {
                                            setState(() {
                                              betAmt++;
                                            })
                                          },
                                      icon: Icon(Icons.add_circle_outline)),
                                ],
                              ),
                            ])))
              ],
            ))
        //
        // Container(
        //     child:
        //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Text("Bet Amount?"),
        //       formFieldText("in dollars", pBet),
        //       smallButton(
        //           context,
        //           'Confirm',
        //           () => {
        //                 if (RegExp(r'^[0-9]+$').hasMatch(pBet.text) && !betSet)
        //                   {
        //                     p.bet = num.parse(pBet.text),
        //                     addUser(p),
        //                     betSet = true
        //                   }
        //                 else
        //                   {
        //                     if (betSet)
        //                       {
        //                         showDialog(
        //                             context: context,
        //                             builder: (_) => AlertDialog(
        //                                   title: Text('Bet has already been set'),
        //                                   content: Text(
        //                                       'Please complete venmo request'),
        //                                 ))
        //                       }
        //                     else
        //                       {
        //                         showDialog(
        //                             context: context,
        //                             builder: (_) => AlertDialog(
        //                                   title: Text('Please check bet amount'),
        //                                   content:
        //                                       Text('Bet amount contains letters'),
        //                                 ))
        //                       }
        //                   }
        //               })
        //     ],
        //   ),
        //   checkCompleteVenmo(context, p),
        //   lookUpLobby(context, p.partyCode),
        // ])),
        );
  }
}
