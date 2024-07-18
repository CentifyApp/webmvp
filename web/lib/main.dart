import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web/choosewinner.dart';
import 'package:web/firebase_options.dart';
import 'package:web/inGame.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/name.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web/error.dart';
import 'package:web/models/playerInfo.dart';
import 'dart:html' as html;
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:web/betAmt.dart';

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
      title: 'SideQuest',
      theme: themeData(),
      home: const MyHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => MyHomePage());
        }
        if (settings.name == '/name') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => namePage());
        }
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'lobby') {
          var arg = uri.pathSegments[1];
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => betLobby(
                  arg: arg)); //lets try if globals keeps value after refresh
        }
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'inGame') {
          var arg = uri.pathSegments[1];
          return MaterialPageRoute(
              settings: settings, builder: (context) => inGame(arg: arg));
        }
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'choose_winner') {
          var arg = uri.pathSegments[1];
          return MaterialPageRoute(
              settings: settings, builder: (context) => chooseWinner(arg: arg));
        }

        return MaterialPageRoute(
            settings: settings, builder: (context) => UnknownScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController lobbyCodeController = TextEditingController();
  UserCredential? _currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  Player p = globals.player;
  User? user;
  var partyCode = "";

  @override
  void initState() {
    super.initState();
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 1080;

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color(0xFFEAF2FF)),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "Play. Win. Earn Cash.",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                Text("Join a Party:",
                    style: Theme.of(context).textTheme.bodySmall),
                formFieldText("Party PIN", lobbyCodeController),
                const SizedBox(height: 30),
                SignInButton(Buttons.GoogleDark, text: "Join with Google",
                    onPressed: () async {
                  if (lobbyCodeController.text == null ||
                      lobbyCodeController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Please complete field',
                                  style: Theme.of(context).textTheme.bodySmall),
                              content: Text('Party PIN is not complete',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ));
                  } else {
                    _currentUser = await signInWithGoogle();
                    globals.player.partyCode = lobbyCodeController.text;
                    globals.player.useruid = _currentUser!.user!.uid;
                    Navigator.pushNamed(context, '/name');
                  }
                }),
                const SizedBox(height: 40),
                Text("How to play?",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 30),
                Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                    children: [
                      Container(
                          width: 320,
                          height: 380,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("1. Join or Create a Party",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Image.asset('assets/centify1.jpg')
                            ],
                          )),
                      const SizedBox(width: 10, height: 10),
                      Container(
                          width: 320,
                          height: 380,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "2. Place bet through Stripe window and start playing!",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Image.asset('assets/centify2.jpg')
                            ],
                          )),
                      // const SizedBox(width: 10, height: 10), //TODO: add this back in
                      // Container(
                      //     width: 320,
                      //     height: 380,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text("3. Win and Get Paid!",
                      //             style: Theme.of(context).textTheme.bodySmall),
                      //         Image.asset('assets/centify3.jpg')
                      //       ],
                      //     ))
                    ]),
                const SizedBox(height: 20),
                Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Have Questions?',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Connect with our agents at sidequest.bet@gmail.com. We are here 24/7 for you!',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ))
              ]),
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            _currentUser = await signInWithGoogle();
            partyCode = generateLobbyCode();
            createLobby(partyCode);
            globals.player.partyCode = partyCode;
            globals.player.useruid = _currentUser!.user!.uid;
            print(globals.player.useruid);
            Navigator.pushNamed(context, '/name');
          },
          label: const Text("Create New Party"),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.greenAccent[700],
        ));
  }
}
