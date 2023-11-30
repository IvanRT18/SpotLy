import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_movil/models/ubicacion.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Obtiene todos los usuarios de la base de datos
Future<List> getUsuarios() async {
  List usuarios = [];
  CollectionReference collectionReferenceUsuarios = db.collection('Usuario');

  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  queryUsuarios.docs.forEach((user) {
    usuarios.add(user.data());
  });

  return usuarios;
}

//Obtiene todos los lugares de la base de datos
Future<List> getLugares() async {
  List localizaciones = [];
  CollectionReference collectionReferenceUsuarios =
      db.collection('Localizacion');

  QuerySnapshot queryLocalizaciones = await collectionReferenceUsuarios.get();

  queryLocalizaciones.docs.forEach((location) {
    localizaciones.add(location.data());
  });

  return localizaciones;
}

//Agrega un nuevo lugar a la base de datos
Future<void> addLugar(Ubicacion localizacion) async {
  await db.collection('Localizacion').add({
    'nombre_lugar': localizacion.nombreUbicacion,
    'descripcion': localizacion.descripcion,
    'calificacion': localizacion.calificacion,
    'latitud': localizacion.latitud,
    'lonigitud': localizacion.longitud,
  });
}
