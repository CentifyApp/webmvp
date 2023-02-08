import 'dart:collection';

import 'package:flutter/material.dart';
import 'buyIn.dart';
import 'models/playerInfo.dart';

class oneVsOne extends StatefulWidget {
  const oneVsOne({Key? key}) : super(key: key);

  @override
  oneVsOneState createState() {
    return oneVsOneState();
  }
}

class oneVsOneState extends State<oneVsOne> {
  final _formKey = GlobalKey<FormState>();
  List<Player> players = [
    Player(name: "p1", venmo: "venmo"),
    Player(name: "p2", venmo: "venmo")
  ];

  TextEditingController p1Name = TextEditingController();
  TextEditingController p1Venmo = TextEditingController();
  TextEditingController p2Name = TextEditingController();
  TextEditingController p2Venmo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centify"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text("Player 1"),
                Flexible(
                    child: TextFormField(
                  controller: p1Name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                Flexible(
                    child: TextFormField(
                  controller: p1Venmo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '@venmo',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.substring(0, 1) != '@') {
                      return 'Please enter your venmo address with @';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () {
                      players[0] =
                          Player(name: p1Name.text, venmo: p1Venmo.text);
                    },
                    child: Text("Confirm"))
              ],
            ),
            Row(
              children: [
                Text("Player 2"),
                Flexible(
                    child: TextFormField(
                  controller: p2Name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                Flexible(
                    child: TextFormField(
                  controller: p2Venmo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '@venmo',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.substring(0, 1) != '@') {
                      return 'Please enter your venmo address with @';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () {
                      players[1] =
                          Player(name: p2Name.text, venmo: p2Venmo.text);
                    },
                    child: Text("Confirm"))
              ],
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return buyIn(playerInfo: players);
                          }))
                        }
                    },
                child: const Text("Next"))
          ],
        ),
      ),
    );
  }
}
