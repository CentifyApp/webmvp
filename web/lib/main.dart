import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web/betAmt.dart';
// import 'package:web/enterParty.dart';
import 'package:web/firebase_options.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/name.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';

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
  TextEditingController lobbyCodeController = TextEditingController();
  var partyCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bet on your own games"),
        ),
        body: theContainer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enter Party Code"),
              formFieldText("Party PIN", lobbyCodeController),
              smallButton(
                  context,
                  "Enter",
                  () => {
                        if (lobbyCodeController.text == null ||
                            lobbyCodeController.text.isEmpty)
                          {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text('Please complete field'),
                                      content:
                                          Text('Party PIN is not complete'),
                                    ))
                          }
                        else
                          {
                            partyCode = lobbyCodeController.text,
                            nextPage(context, namePage(partyCode: partyCode)),
                          }
                      })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
            partyCode = generateLobbyCode(),
            createLobby(partyCode),
            nextPage(context, namePage(partyCode: partyCode))
          },
          label: const Text("Create New Party"),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.orangeAccent,
        ));
  }
}
