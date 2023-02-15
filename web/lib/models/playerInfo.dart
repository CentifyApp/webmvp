import 'package:http/http.dart';

class Player {
  Player(
      {required this.name,
      required this.venmo,
      this.ready = false,
      this.isWinner = false,
      this.bet = 0,
      this.partyCode = ""});

  String name;
  String venmo;
  String partyCode;
  bool ready, isWinner;
  num bet;

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "venmo": venmo,
      "ready": ready,
      "isWinner": isWinner,
      "bet": bet,
      "partyCode": partyCode
    };
  }
}
