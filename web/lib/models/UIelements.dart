import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bigButton(BuildContext context, String text, Function()? onPress) {
  return SizedBox(
    width: 300,
    height: 100,
    child: ElevatedButton(
        onPressed: onPress,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge))),
  );
}

Widget smallButton(BuildContext context, String text, Function()? onPress) {
  return SizedBox(
    width: 100,
    height: 33,
    child: ElevatedButton(
        onPressed: onPress,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: [
                Text(text, style: Theme.of(context).textTheme.bodySmall),
              ],
            ))),
  );
}

Widget bigIconButton(
    BuildContext context, String text, Icon icon, Function()? onPress) {
  return SizedBox(
    width: 300,
    height: 50,
    child: ElevatedButton.icon(
      onPressed: onPress,
      icon: icon,
      label: Text(text, style: Theme.of(context).textTheme.bodySmall),
    ),
  );
}

Widget formFieldText(String label, TextEditingController controller) {
  return SizedBox(
      width: 500,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
      ));
}

ThemeData themeData() {
  return ThemeData(
      primarySwatch: Colors.purple,
      textTheme: GoogleFonts.poppinsTextTheme(TextTheme(
          bodySmall: TextStyle(fontSize: 20, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 20),
          bodyLarge: TextStyle(fontSize: 28, color: Colors.white))),
      scaffoldBackgroundColor: Color.fromARGB(255, 248, 187, 249));
}

Container theContainer(BuildContext context, Widget child) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(50),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.orangeAccent, Colors.purpleAccent])),
    child: child,
  );
}
