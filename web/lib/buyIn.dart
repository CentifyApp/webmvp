import 'package:flutter/material.dart';
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
          const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              int i = 0;
              while (i < players.length && players[i].ready) {
                i++;
              }

              if (i == players.length) {
                print("go to next page");
              } else {
                print("nope");
              }
            },
            child: Text("Start"),
          )
        ],
      )),
    );
  }
}
