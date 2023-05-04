import 'package:emailjs/emailjs.dart';
import 'package:web/models/playerInfo.dart';
import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';
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

void sendEmail(String venmo, String pot) async {
  try {
    await EmailJS.send(
      'service_qudqnud',
      'template_y90zvng',
      {
        'user_email': '2096326874fhua@gmail.com',
        'venmo': venmo,
        'from_name': 'Centify',
        'amount': pot
      },
      const Options(
        publicKey: 'l7BGC0bJaRInozTFn',
        privateKey: 'IOo5gKIktWLwvT4d4pxYd',
      ),
    );
    print('SUCCESS!');
  } catch (error) {
    if (error is EmailJSResponseStatus) {
      print('ERROR... ${error.status}: ${error.text}');
    }
    print(error.toString());
  }
}
