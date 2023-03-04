import 'package:flutter/material.dart';
import 'package:web/betAmt.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/firebase.dart';
import 'models/playerInfo.dart';
import 'package:web/utils/functions.dart';

class makeLobby extends StatelessWidget {
  final Player player1;
  const makeLobby({Key? key, required this.player1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController lobbyCodeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            bigButton(
                context,
                "Create Party",
                () => {
                      player1.partyCode = generateLobbyCode(),
                      // addUser(player1),
                      // nextPage(context, betLobby(player: player1))
                    }),
            Text("Or"),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Enter Party Code"),
                  formFieldText("Party code", lobbyCodeController),
                  smallButton(
                      context,
                      "Next",
                      () => {
                            if (lobbyCodeController.text == null ||
                                lobbyCodeController.text.isEmpty)
                              {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text('Please complete field'),
                                          content: Text(
                                              'Party code is not complete'),
                                        ))
                              }
                            else
                              {
                                player1.partyCode = lobbyCodeController.text,
                                // addUser(player1),
                                // nextPage(context, betLobby(player: player1)),
                              }
                          })
                ],
              ),
            )
          ])),
    );
  }
}
