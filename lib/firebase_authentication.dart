// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_movil/models/usuario.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(Usuario nuevoUsuario) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: nuevoUsuario.correo, password: nuevoUsuario.password);
      print("Credenciales");
      print(credential);
      return credential.user;
    } catch (e) {
      print("Ocurrio un error FirebaseAuth");
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(Usuario nuevoUsuario) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: nuevoUsuario.correo, password: nuevoUsuario.password);
      print("Credenciales");
      print(credential);
      return credential.user;
    } catch (e) {
      print("Ocurrio un al iniciar sesion en FirebaseAuth");
    }

    return null;
  }
}
