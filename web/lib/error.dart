import 'package:flutter/material.dart';
import 'package:web/models/UIelements.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: theContainer(context, Text('404!')),
    );
  }
}
