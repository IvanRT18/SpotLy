import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios() async {
  List usuarios = [];
  CollectionReference collectionReferenceUsuarios = db.collection('Usuario');

  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  queryUsuarios.docs.forEach((user) {
    usuarios.add(user.data());
  });

  return usuarios;
}

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
