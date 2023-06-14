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
                    ElevatedButton(
                        onPressed: () => setState(() {
                              _offStage = 1;
                            }),
                        child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              children: [
                                Text("Yes",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            ))),
                    ElevatedButton(
                        onPressed: () => setState(() {
                              _offStage = 2;
                            }),
                        child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              children: [
                                Text("No",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            )))
                  ],
                ),
                if (_offStage == 1)
                  Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Complete Venmo handle (click to copy) and submit to sidequest.bet@gmail.com",
                            style: Theme.of(context).textTheme.bodySmall),
                        SelectableText.rich(
                          TextSpan(
                              text:
                                  "Name: ${name} \nParty: ${partyCode} \nVenmo: ",
                              style: Theme.of(context).textTheme.bodySmall,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "Name: ${name} \nParty: ${partyCode} \nVenmo: "));
                                }),
                        ),
                        Text(
                            "Please also attach a photo for proof and allow 1 day to process.",
                            style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(height: 20),
                        Text(
                            "Please let us know any feedbacks or requests at sidequest.bet@gmail.com",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              globals.player = new Player();
                              Navigator.pushNamed(context, '/');
                            },
                            child: const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    Text("Play Again",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                )))
                      ],
                    )
                  ]),
                if (_offStage == 2)
                  Column(children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Better luck next time!",
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(
                              "Please let us know any requests or feedbacks at sidequest.bet@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall),
                        ]),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              globals.player = new Player();
                              Navigator.pushNamed(context, '/');
                            },
                            child: const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    Text("Play Again",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                )))
                      ],
                    )
                  ])
              ],
            )));
  }
}
