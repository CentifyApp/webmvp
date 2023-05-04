import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

class chooseWinner extends StatefulWidget {
  final String arg;
  const chooseWinner({Key? key, required this.arg}) : super(key: key);

  @override
  chooseWinnerState createState() {
    return chooseWinnerState();
  }
}

class chooseWinnerState extends State<chooseWinner> {
  int _offStage = 0;
  num pot = 0;

  @override
  Widget build(BuildContext context) {
    String p = widget.arg;
    String partyCode = p.split('_')[0];
    String name = p.split('_')[1];

    return Scaffold(
        appBar: AppBar(title: Text("Party: " + partyCode)),
        body: theContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Are you the winner?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallButton(
                        context,
                        "Yes",
                        () => setState(() {
                              _offStage = 1;
                            })),
                    smallButton(
                        context,
                        "No",
                        () => setState(() {
                              _offStage = 2;
                            }))
                  ],
                ),
                if (_offStage == 1)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                            "Text 415-769-8863 the following with your venmo handle:"),
                        SelectableText.rich(
                          TextSpan(
                              text:
                                  "Name: ${name} \nParty: ${partyCode} \nVenmo: ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "Name: ${name} \nParty: ${partyCode} \nVenmo: "));
                                }),
                        ),
                        Text("Please also attach a photo for proof."),
                        SizedBox(height: 20),
                        Text(
                            "Please feel free to let me know any feedback you have!"),
                        smallButton(context, "Play Again", () {
                          globals.player = new Player();
                          Navigator.pushNamed(context, '/');
                        })
                      ]),
                if (_offStage == 2)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Better luck next time!"),
                        Text(
                            "Please feel free to let me know any feedback you have, just text 415-769-8863!"),
                        smallButton(context, "Play Again", () {
                          globals.player = new Player();
                          Navigator.pushNamed(context, '/');
                        })
                      ]),
              ],
            )));
  }
}
