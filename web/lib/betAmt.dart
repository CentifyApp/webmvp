import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/models/playerInfo.dart';
import 'package:web/utils/firebase.dart';
import 'package:web/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
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
            title: Text.rich(TextSpan(children: [
          WidgetSpan(
            child: Icon(Icons.ios_share),
          ),
          TextSpan(
              text:
                  "     Bet on this match with me at Centify.Games! Code: ${party}"),
        ]))),
        body: theContainer(
            context,
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 450,
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
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: SizedBox(
                          width: 250,
                          height: 150,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Place your bets!"),
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
                                        icon:
                                            Icon(Icons.remove_circle_outline)),
                                    Text('\$' +
                                        _price
                                            .toString()), //make _val editable with textfield

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
                ])));
  }
}
