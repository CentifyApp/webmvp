import 'package:flutter/material.dart';

class chooseWinner extends StatelessWidget {
  final List playerInfo;
  const chooseWinner({Key? key, required this.playerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Centify"),
        ),
        body: Column());
  }
}
