import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web/firebase_options.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Centify',
      theme: themeData(),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Play with Centify and bet on your games"),
            bigButton(
                context,
                "Play Now",
                () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return namePage();
                      }))
                    })
          ],
        ),
      ),
    );
  }
}
