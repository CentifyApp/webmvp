import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class inGame extends StatefulWidget {
  final String arg;
  const inGame({Key? key, required this.arg}) : super(key: key);

  @override
  inGameState createState() {
    return inGameState();
  }
}

class inGameState extends State<inGame> {
  @override
  Widget build(BuildContext context) {
    String party = widget.arg.split('_')[0];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: SelectableText.rich(TextSpan(children: [
        WidgetSpan(
          child: Icon(Icons.ios_share),
        ),
        TextSpan(
            text:
                "     Bet on this match with me at Centify.Games! Code: ${party}",
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Clipboard.setData(ClipboardData(
                    text:
                        "Bet on this match with me at Centify.Games! Code: ${party}"));
              }),
      ]))),
      body: theContainer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Game in progress..."),
              CircularProgressIndicator(),
              smallButton(
                  context,
                  "End?",
                  () => Navigator.pushNamed(
                      context, 'choose_winner/${widget.arg}'))
            ],
          )),
    );
  }
}
