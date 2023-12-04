class Ubicacion {
  String nombreUbicacion;
  String descripcion;
  double calificacion;
  double longitud, latitud;
  String id;

  Ubicacion(
      {this.calificacion = 0.0,
      this.latitud = 0.0,
      this.longitud = 0.0,
      this.nombreUbicacion = "",
      this.descripcion = "",
      this.id = ""});
}
