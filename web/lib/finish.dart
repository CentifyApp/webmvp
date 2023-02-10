import 'package:flutter/material.dart';
import 'package:web/main.dart';
import 'models/playerInfo.dart';

class finish extends StatelessWidget {
  final Player winner;
  final num pot;
  const finish({Key? key, required this.winner, required this.pot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Centify"),
        ),
        body: Column(
          children: [
            Text(winner.name +
                " has won \$" +
                pot.toString() +
                ", your rewards will arrive shortly"),
            Spacer(),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(
                          title: 'Home Page',
                        );
                      }))
                    },
                child: Text("Finish"))
          ],
        ));
  }
}
