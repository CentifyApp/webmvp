class Player {
  Player({required this.name, required this.venmo, this.ready = false});

  final String name;
  final String venmo;
  bool ready;
}
