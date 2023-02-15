import 'package:flutter/material.dart';
import 'package:web/ingame.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/venmo.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';

class namePage extends StatelessWidget {
  const namePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController playerName = TextEditingController();
    Player p = Player(name: 'name', venmo: 'venmo');

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Player name?"),
                formFieldText("Name", playerName),
                smallButton(
                    context,
                    "Next",
                    () => {
                          print(playerName.text),
                          if (playerName.text == null ||
                              playerName.text.isEmpty)
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
                              addUser(p),
                              nextPage(context, venmoPage(player: p))
                            }
                        })
              ])),
    );
  }
}
