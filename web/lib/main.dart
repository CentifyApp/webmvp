import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:web/firebase_options.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/name.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web/error.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:web/models/playerInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'globals.dart' as globals;
import 'package:web/betAmt.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
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
      home: const MyHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => MyHomePage());
        }
        if (settings.name == '/name') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => namePage());
        }
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'lobby') {
          print('working');
          var arg = uri.pathSegments[1];
          // var id = arg.split('_')[0];
          // var name = arg.split('_')[1];

          return MaterialPageRoute(
              settings: settings,
              builder: (context) => betLobby(
                  arg: arg)); //lets try if globals keeps value after refresh
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
  String _contactText = '';
  var partyCode = "";

  // @override
  // void initState() {
  //   super.initState();
  //   // GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //   // googleProvider
  //   //     .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //   // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
  //   // _googleSignIn.signInSilently();
  // }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

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
              bigIconButton(
                  context, "Continue with Google", Icon(Icons.person_add_alt_1),
                  () async {
                if (lobbyCodeController.text == null ||
                    lobbyCodeController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Please complete field'),
                            content: Text('Party PIN is not complete'),
                          ));
                } else {
                  _currentUser = await signInWithGoogle();
                  globals.player.partyCode = lobbyCodeController.text;
                  globals.player.useruid = _currentUser!.user!.uid;
                  Navigator.pushNamed(context, '/name');
                }
              })
            ],
          ),
        ),
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
          backgroundColor: Colors.orangeAccent,
        ));
  }
}
