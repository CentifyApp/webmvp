import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:web/firebase_options.dart';
import 'package:web/models/UIelements.dart';
import 'package:web/startupFiles/name.dart';
import 'package:web/utils/functions.dart';
import 'package:web/utils/firebase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:web/models/playerInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:web/betAmt.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
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
      // initialRoute: '/home',
      // routes: {
      //   '/home': (context) => const MyHomePage(title: 'Home Page'),
      //   '/party': (context) => betLobby(),
      // }
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
  UserCredential? _currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  Player p = new Player(name: "", venmo: "");
  User? user;
  String _contactText = '';
  var partyCode = "";

  @override
  void initState() {
    super.initState();
    // GoogleAuthProvider googleProvider = GoogleAuthProvider();
    // googleProvider
    //     .addScope('https://www.googleapis.com/auth/contacts.readonly');
    // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    // _googleSignIn.signInSilently();
  }

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
                  partyCode = lobbyCodeController.text;
                  p.useruid = _currentUser!.user!.uid;
                  // Navigator.of(context).pushNamed('/party',
                  //     arguments: betLobby(partyCode: partyCode));
                  nextPage(context, namePage(partyCode: partyCode));
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
