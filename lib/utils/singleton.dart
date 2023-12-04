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

  String idSeleccionado = "";
  String nombreSeleccionado = "";
  String descripcionSeleccionado = "";
  double calificacionSeleccionado = 0;
  double latSeleccionado = 0;
  double longSeleccionado = 0;
}
