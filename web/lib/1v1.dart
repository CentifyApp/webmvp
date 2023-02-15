import 'package:flutter/material.dart';
import 'models/playerInfo.dart';
import 'ingame.dart';

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
    Player(name: "p1", venmo: "venmo", ready: false),
    Player(name: "p2", venmo: "venmo", ready: false)
  ];

  TextEditingController p1Name = TextEditingController();
  TextEditingController p1Venmo = TextEditingController();
  TextEditingController p2Name = TextEditingController();
  TextEditingController p2Venmo = TextEditingController();
  TextEditingController p1bet = TextEditingController();
  TextEditingController p2bet = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        !value.contains('@')) {
                      return 'Please enter your venmo address with @';
                    }
                    return null;
                  },
                )),
                Flexible(
                    child: TextFormField(
                  controller: p1bet,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    border: OutlineInputBorder(),
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains('.') ||
                        !RegExp(r'^[0-9]+$').hasMatch(p1bet.text)) {
                      return 'Numbers only';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[0].name = p1Name.text;
                          players[0].venmo = p1Venmo.text;
                          players[0].ready = !(players[0].ready);
                          if (RegExp(r'^[0-9]+$').hasMatch(p1bet.text)) {
                            players[0].bet = num.parse(p1bet.text);
                          }
                          print(players[0].ready);
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[0].ready ? Colors.green : Colors.purple)),
                    child: Text(players[0].name + " ready")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    border: OutlineInputBorder(),
                    labelText: 'Bet dollar amount *',
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains('.') ||
                        !RegExp(r'^[0-9]+$').hasMatch(p2bet.text)) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )),
                ElevatedButton(
                    onPressed: () => setState(() {
                          players[1].name = p2Name.text;
                          players[1].venmo = p2Venmo.text;
                          players[1].ready = !players[1].ready;
                          if (RegExp(r'^[0-9]+$').hasMatch(p2bet.text)) {
                            players[1].bet = num.parse(p2bet.text);
                          }
                          print(players[1].ready);
                        }),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            players[1].ready ? Colors.green : Colors.purple)),
                    child: Text(players[1].name + " ready")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Venmo your bets then click ready"),
                Image.asset(
                  'assets/venmo.jpg',
                  width: 300,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  int i = 0;

                  for (int k = 0; k < players.length; k++) {
                    if (!players[k].ready || (players[k].venmo == "venmo")) {
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
                      return inGame();
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
