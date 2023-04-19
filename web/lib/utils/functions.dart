import 'package:emailjs/emailjs.dart';
import 'package:web/models/playerInfo.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void nextPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

String generateLobbyCode() {
  var code = Random().nextInt(89999) + 10000;
  return code.toString();
}
