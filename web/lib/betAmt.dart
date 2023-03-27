import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/utils/firebase.dart';
import 'package:web/utils/stripe.dart';

class betLobby extends StatefulWidget {
  static String route = '/';
  final String partyCode;
  // final Player player;

  betLobby({Key? key, required this.partyCode}) : super(key: key);

  @override
  betLobbyState createState() {
    return betLobbyState();
  }
}

int betAmt = 0;

class betLobbyState extends State<betLobby> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String party = widget.partyCode;
    // Player p = widget.player;
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
                                        icon:
                                            Icon(Icons.remove_circle_outline)),
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
                                TextButton(
                                    onPressed: () => {
                                          makePayment(),
                                        },
                                    child: Text("Make Payment"))
                              ])))
                ])));
  }
}
