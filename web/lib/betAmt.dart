import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/utils/firebase.dart';
import 'package:web/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'dart:html' as html;

class betLobby extends StatefulWidget {
  final String arg;

  betLobby({Key? key, required this.arg}) : super(key: key);

  @override
  betLobbyState createState() {
    return betLobbyState();
  }
}

int _priceIndex = 9;
int _price = globals.priceList[_priceIndex];

class betLobbyState extends State<betLobby> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String party = widget.arg.split('_')[0];
    String name = widget.arg.split('_')[1];
    bool betSet = false;

    String paymentURL = "";

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: SelectableText.rich(TextSpan(children: [
          WidgetSpan(
            child: Icon(Icons.ios_share),
          ),
          TextSpan(
              text: "     Join this wager at Sidequest.bet! Code: ${party}",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  Clipboard.setData(ClipboardData(
                      text:
                          "Join this wager at Sidequest.bet! Code: ${party}"));
                }),
        ]))),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 350,
                    child: FutureBuilder(
                        future: returnLobby(context, party, name),
                        builder: (BuildContext context,
                            AsyncSnapshot<Widget> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!;
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else {
                            return CircularProgressIndicator();
                          }
                        })),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                        width: 230,
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Place your bets!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            setState(() {
                                              _priceIndex <= 0
                                                  ? _priceIndex = 0
                                                  : _priceIndex--;
                                              _price = globals
                                                  .priceList[_priceIndex];
                                            })
                                          },
                                      icon: Icon(Icons.remove_circle_outline)),
                                  Text('\$' + _price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium), //make _val editable with textfield

                                  IconButton(
                                      onPressed: () => {
                                            setState(() {
                                              _priceIndex < 20
                                                  ? _priceIndex++
                                                  : _priceIndex = 20;
                                              _price = globals
                                                  .priceList[_priceIndex];
                                            })
                                          },
                                      icon: Icon(Icons.add_circle_outline)),
                                ],
                              ),
                              paymentButtonToNextPage(
                                  context, party, name, _price)
                            ])))
              ]),
        ));
  }
}
