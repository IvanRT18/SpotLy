class Ubicacion {
  String nombreUbicacion;
  String descripcion;
  double calificacion;
  double longitud, latitud;

  Ubicacion(
      {this.calificacion = 0,
      this.latitud = 0,
      this.longitud = 0,
      this.nombreUbicacion = "",
      this.descripcion = ""});
}