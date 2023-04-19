import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/firebase.dart';
import 'package:web/globals.dart' as globals;

class namePage extends StatelessWidget {
  const namePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController playerName = TextEditingController();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text("Party: " + globals.player.partyCode)),
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
                            globals.player.name = playerName.text,
                            addUser(globals.player),
                            Navigator.pushNamed(context,
                                '/lobby/${globals.player.partyCode}_${globals.player.name}',
                                arguments:
                                    '${globals.player.partyCode}_${globals.player.name}')
                          }
                      })
            ])));
  }
}
