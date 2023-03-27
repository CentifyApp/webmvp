import 'package:flutter/material.dart';
import 'package:web/betAmt.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/venmo.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';

class namePage extends StatelessWidget {
  final String partyCode;
  const namePage({Key? key, required this.partyCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Player p = Player(name: "name", venmo: "venmo", partyCode: partyCode);
    TextEditingController playerName = TextEditingController();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text("Party: " + partyCode)),
        body: theContainer(
            context,
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text("Player name?"),
              formFieldText("Name", playerName),
              smallButton(
                  context,
                  "Join",
                  () => {
                        print(playerName.text),
                        if (playerName.text == null || playerName.text.isEmpty)
                          {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text('Please complete field'),
                                      content: Text('Name is not complete'),
                                    ))
                          }
                        else
                          {
                            p.name = playerName.text,
                            addUser(p, partyCode),
                            nextPage(context, betLobby(partyCode: partyCode))
                          }
                      })
            ])));
  }
}
