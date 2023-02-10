import 'dart:collection';

import 'package:flutter/material.dart';
import 'ingame.dart';
import 'models/playerInfo.dart';

class twoVsTwo extends StatefulWidget {
  const twoVsTwo({Key? key}) : super(key: key);

  @override
  twoVsTwoState createState() {
    return twoVsTwoState();
  }
}

class twoVsTwoState extends State<twoVsTwo> {
  final _formKey = GlobalKey<FormState>();
  List<Player> players = [
    Player(name: "p1", venmo: "venmo"),
    Player(name: "p2", venmo: "venmo"),
    Player(name: "p3", venmo: "venmo"),
    Player(name: "p4", venmo: "venmo")
  ];

  TextEditingController p1Name = TextEditingController();
  TextEditingController p1Venmo = TextEditingController();
  TextEditingController p2Name = TextEditingController();
  TextEditingController p2Venmo = TextEditingController();
  TextEditingController p3Name = TextEditingController();
  TextEditingController p3Venmo = TextEditingController();
  TextEditingController p4Name = TextEditingController();
  TextEditingController p4Venmo = TextEditingController();
  TextEditingController p1bet = TextEditingController();
  TextEditingController p2bet = TextEditingController();
  TextEditingController p3bet = TextEditingController();
  TextEditingController p4bet = TextEditingController();

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
                Flexible(
                    child: TextFormField(
                  controller: p1bet,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'How much do you want to bet?',
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.contains('.')) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[0] =
                              Player(name: p1Name.text, venmo: p1Venmo.text);
                          players[0].bet = num.parse(p1bet.text);
                          players[0].ready = !players[0].ready;

                          print(players[0].bet);
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[0].ready ? Colors.green : Colors.purple)),
                    child: Text(players[0].name + " ready")),
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
                Flexible(
                    child: TextFormField(
                  controller: p2bet,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'How much do you want to bet?',
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.contains('.')) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[1] =
                              Player(name: p2Name.text, venmo: p2Venmo.text);
                          players[1].bet = num.parse(p2bet.text);
                          players[1].ready = !players[1].ready;
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[1].ready ? Colors.green : Colors.purple)),
                    child: Text(players[1].name + " ready")),
              ],
            ),
            Row(
              children: [
                Text("Player 3"),
                Flexible(
                    child: TextFormField(
                  controller: p3Name,
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
                  controller: p3Venmo,
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
                Flexible(
                    child: TextFormField(
                  controller: p3bet,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'How much do you want to bet?',
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.contains('.')) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[2] =
                              Player(name: p3Name.text, venmo: p3Venmo.text);
                          players[2].bet = num.parse(p3bet.text);
                          players[2].ready = !players[2].ready;
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[2].ready ? Colors.green : Colors.purple)),
                    child: Text(players[2].name + " ready"))
              ],
            ),
            Row(
              children: [
                Text("Player 4"),
                Flexible(
                    child: TextFormField(
                  controller: p4Name,
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
                  controller: p4Venmo,
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
                Flexible(
                    child: TextFormField(
                  controller: p4bet,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'How much do you want to bet?',
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.contains('.')) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[3] =
                              Player(name: p4Name.text, venmo: p4Venmo.text);
                          players[3].bet = num.parse(p4bet.text);
                          players[3].ready = !players[3].ready;
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[3].ready ? Colors.green : Colors.purple)),
                    child: Text(players[3].name + " ready"))
              ],
            ),
            Spacer(),
            Image.asset(
              'assets/venmo.jpg',
              width: 300,
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  int i = 0;

                  for (int k = 0; k < players.length; k++) {
                    if (!players[k].ready) {
                      i++;
                    }
                  }
                  if (i != 0) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Players are not ready!'),
                              content: Text('Check if all player has venmoed'),
                            ));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return inGame(playerInfo: players);
                    }));
                  }
                },
                child: const Text("Start Game"))
          ],
        ),
      ),
    );
  }
}
