import 'package:flutter/material.dart';
import 'package:web/choosewinner.dart';

class inGame extends StatelessWidget {
  final List playerInfo;
  const inGame({Key? key, required this.playerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Centify"),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return chooseWinner(playerInfo: playerInfo);
                      }))
                    },
                child: Text("Finish"))
          ],
        ));
  }
}
