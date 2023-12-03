class Singleton {
  static Singleton? _instance;

  Singleton._internal() {
    _instance = this;
  }

  factory Singleton() => _instance ?? Singleton._internal();

  bool darkMode = false;

  void toggleDarkMode() {
    darkMode = !darkMode;
  }
}
