class Player {
  Player(
      {required this.name,
      required this.venmo,
      this.ready = false,
      this.isWinner = false});

  final String name;
  final String venmo;
  bool ready, isWinner;
}
