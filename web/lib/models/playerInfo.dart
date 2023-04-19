class Player {
  Player(
      {this.name = "",
      this.venmo = "",
      this.ready = false,
      this.isWinner = false,
      this.bet = 0,
      this.partyCode = "",
      this.useruid = ""});

  String name;
  String venmo;
  String partyCode;
  bool ready, isWinner;
  num bet;
  String useruid;

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "venmo": venmo,
      "ready": ready,
      "isWinner": isWinner,
      "bet": bet,
      "partyCode": partyCode,
      "useruid": useruid
    };
  }

  Player.fromJSON(Map<String, dynamic> json)
      : name = json["name"],
        venmo = json["venmo"],
        ready = json["ready"],
        isWinner = json["isWinner"],
        bet = json["bet"],
        partyCode = json["partyCode"],
        useruid = json["useruid"];
}
