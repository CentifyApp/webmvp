import 'dart:collection';

import 'package:flutter/material.dart';

void main() => runApp(oneVsOne());

class oneVsOne extends StatelessWidget {
  oneVsOne({Key? key}) : super(key: key);
  Map users = new Map<String, String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centify"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: const [
                Text("Player 1"),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Venmo',
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text("Player 2"),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Venmo',
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            ElevatedButton(onPressed: () => {}, child: const Text("Next"))
          ],
        ),
      ),
    );
  }
}
