import 'package:flutter/material.dart';
import 'package:web/choosewinner.dart';
import 'package:web/main.dart';
import 'models/playerInfo.dart';

class finish extends StatelessWidget {
  final Player winner;
  const finish({Key? key, required this.winner}) : super(key: key);

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
