import 'package:flutter/material.dart';
import 'package:web/enterParty.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';

class venmoPage extends StatelessWidget {
  Player player;
  venmoPage({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController venmoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Venmo?"),
                formFieldText("Include @ sign, Ex. @abc123", venmoController),
                smallButton(
                    context,
                    "Next",
                    () => {
                          if (venmoController.text == null ||
                              venmoController.text.isEmpty ||
                              venmoController.text.substring(0, 1) != "@")
                            {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Please complete field'),
                                        content: Text('Venmo is not complete'),
                                      ))
                            }
                          else
                            {
                              player.venmo = venmoController.text,
                              // addUser(player),
                              nextPage(context, makeLobby(player1: player))
                            }
                        })
              ])),
    );
  }
}
