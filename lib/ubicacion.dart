import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ubicacion {
  String nombreUbicacion;
  String descripcion;
  int calificacion;
  double longitud, latitud;

  Ubicacion(
      {this.calificacion = 0,
      this.latitud = 0,
      this.longitud = 0,
      this.nombreUbicacion = "",
      this.descripcion = ""});
}
