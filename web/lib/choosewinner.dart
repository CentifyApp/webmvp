import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/finish.dart';
import 'package:web/models/playerInfo.dart';
import 'utils/functions.dart';

class chooseWinner extends StatefulWidget {
  final List playerInfo;
  const chooseWinner({Key? key, required this.playerInfo}) : super(key: key);

  @override
  chooseWinnerState createState() {
    return chooseWinnerState();
  }
}

class chooseWinnerState extends State<chooseWinner> {
  var items = ['win', 'lose'];
  List<String> dropdownvalues = [];
  num pot = 0;

  @override
  Widget build(BuildContext context) {
    List players = widget.playerInfo;
    List<Widget> winlose = [];

    for (int i = 0; i < players.length; i++) {
      dropdownvalues.add("lose");
      winlose.add(
        Column(
          children: [
            Text(players[i].name),
            DropdownButton(
                value: dropdownvalues[i],
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalues[i] = newValue!;
                    dropdownvalues[i] == 'lose'
                        ? players[i].isWinner = false
                        : players[i].isWinner = true;
                  });
                })
          ],
        ),
      );
    }

    return Scaffold(
        body: Column(
      children: [
        Row(children: winlose),
        ElevatedButton(
            onPressed: () {
              int i = 0;
              for (var player in players) {
                pot += player.bet;
                if (player.isWinner) {
                  i++;
                }
              }

              if (i == 1) {
                for (var player in players) {
                  if (player.isWinner) {
                    sendEmail(player, pot.toString());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return finish(winner: player, pot: pot);
                    }));
                  }
                }
              } else {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('There can only be one winner'),
                          content: Text('Check with your friends!'),
                        ));
              }
            },
            child: Text("Confirm"))
      ],
    ));
  }
}
