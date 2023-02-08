import 'package:flutter/material.dart';
import 'package:web/ingame.dart';
import 'package:web/models/playerInfo.dart';

/*TODO: 
- 1v1/2v2 page response after confirm player 
- correct logic for checking player ready
*/

class buyIn extends StatefulWidget {
  final List playerInfo;
  const buyIn({Key? key, required this.playerInfo}) : super(key: key);

  @override
  buyInState createState() {
    return buyInState();
  }
}

class buyInState extends State<buyIn> {
  @override
  Widget build(BuildContext context) {
    List players = widget.playerInfo;
    List<Widget> ready = [];

    for (int i = 0; i < players.length; i++) {
      ready.add(
        ElevatedButton(
            onPressed: () => setState(() {
                  players[i].ready = !players[i].ready;
                }),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    players[i].ready ? Colors.green : Colors.purple)),
            child: Text(players[i].name + " ready")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Centify"),
      ),
      body: Center(
          child: Column(
        children: [
          Text("Tap when ready"),
          Spacer(),
          Row(
            children: ready,
          ),
          Spacer(),
          Image.asset(
            'assets/venmo.jpg',
            width: 500,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              int i = 0;

              for (var player in players) {
                if (!player.ready) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return inGame(playerInfo: players);
                }));
              }
            },
            child: Text("Start"),
          )
        ],
      )),
    );
  }
}
