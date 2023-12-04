// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_movil/models/ubicacion.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Obtiene todos los usuarios de la base de datos
Future<List> getUsuarios() async {
  List usuarios = [];
  CollectionReference collectionReferenceUsuarios = db.collection('Usuario');

  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  queryUsuarios.docs.forEach((user) {
    final data = user.data() as Map<String, dynamic>;
    print("IDDDDDDDDDD");
    print(user.id);
    final usuario = {
      "nombre_lugar": data['nombre_lugar'],
      "descripcion": data['descripcion'],
      "calificacion": data['calificacion'],
      "latitud": data['latitud'],
      "longitu": data['longitud'],
      "uid": user.id,
    };
    usuarios.add(user);
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
    final data = location.data() as Map<String, dynamic>;
    print("IDDDDDDDDDD");
    print(location.id);
    final localizacion = {
      "nombre_lugar": data['nombre_lugar'],
      "descripcion": data['descripcion'],
      "calificacion": data['calificacion'],
      "latitud": data['latitud'],
      "longitud": data['longitud'],
      "uid": location.id,
    };

    localizaciones.add(localizacion);
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
    'longitud': localizacion.longitud,
  });
}

//Actualiza un lugar en la base de datos
Future<void> updateLugar(Ubicacion localizacion, String id) async {
  // await db.collection('Localizacion').doc(localizacion.)
}
