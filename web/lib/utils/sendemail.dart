import 'package:emailjs/emailjs.dart';
import 'package:web/models/playerInfo.dart';

void sendEmail(Player winner, String pot) async {
  try {
    await EmailJS.send(
      'service_qudqnud',
      'template_y90zvng',
      {
        'user_email': '2096326874fhua@gmail.com',
        'venmo': winner.venmo,
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
