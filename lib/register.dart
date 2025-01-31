// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_movil/firebase_authentication.dart';

import 'package:proyecto_movil/login.dart';
import 'package:proyecto_movil/models/usuario.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:toastification/toastification.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    userController.dispose();
    super.dispose();
  }

  bool _validarCorreo = false;
  bool _validarContrasena = false;
  bool _validarUsuario = false;

  bool _obscureText = true; // Estado del obscureText

  Usuario nuevoUsuario = Usuario();

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/images/Banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Encabezado
                          const Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400),
                          ),
                          // Espaciado
                          const SizedBox(
                            height: 15,
                          ),
                          // Usuario
                          SizedBox(
                            width: widthDevice * 0.85,
                            child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 132, 132, 128),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                controller: userController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color(0x8C848480),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 20,
                                      color: Color(0x8C848480),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color(0x8C848480),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Usuario",
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 132, 132, 128),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorText: _validarUsuario
                                      ? 'Debe de escribir un nombre de usuario válido'
                                      : null,
                                ),
                                onChanged: (texto) {
                                  setState(() {
                                    if (texto.trim().isNotEmpty) {
                                      _validarUsuario = false;
                                    }
                                  });
                                }),
                          ),
                          // Espaciado
                          const SizedBox(
                            height: 15,
                          ),
                          // Correo
                          SizedBox(
                            width: widthDevice * 0.85,
                            child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 132, 132, 128),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                controller: mailController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color(0x8C848480),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 20,
                                      color: Color(0x8C848480),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color(0x8C848480),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Correo",
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 132, 132, 128),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorText: _validarCorreo
                                      ? 'Debe de escribir un correo válido'
                                      : null,
                                ),
                                onChanged: (texto) {
                                  setState(() {
                                    if (texto.trim().isNotEmpty) {
                                      _validarCorreo = false;
                                    }
                                  });
                                }),
                          ),
                          // Espaciado
                          const SizedBox(
                            height: 15,
                          ),
                          // Contraseña
                          SizedBox(
                            width: widthDevice * 0.85,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 11,
                                  child: TextFormField(
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 132, 132, 128),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      controller: passwordController,
                                      textAlign: TextAlign.left,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0x8C848480),
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0x8C848480),
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0x8C848480),
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "Contraseña",
                                          hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 132, 132, 128),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          errorText: _validarContrasena
                                              ? 'Debe de ser una contraseña mayor a 6 caracteres'
                                              : null),
                                      onChanged: (texto) {
                                        setState(() {
                                          if (texto.trim().isNotEmpty) {
                                            _validarContrasena = false;
                                          }
                                        });
                                      }),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText =
                                                !_obscureText; // Cambia el estado de obscureText
                                          });
                                        },
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        )))
                              ],
                            ),
                          ),
                          // Espaciado
                          const SizedBox(
                            height: 15,
                          ),
                          // Botón Iniciar sesión
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _validarCorreo = mailController
                                            .text.isNotEmpty &&
                                        validaCorreo(mailController.text) == '1'
                                    ? false
                                    : true;

                                _validarContrasena =
                                    passwordController.text.length >= 6 &&
                                            passwordController.text.isNotEmpty
                                        ? false
                                        : true;

                                _validarUsuario = userController.text.isNotEmpty
                                    ? false
                                    : true;

                                if (!_validarCorreo &&
                                    !_validarContrasena &&
                                    !_validarUsuario) {
                                  _signUp();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: verdeApp,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: verdeApp,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              fixedSize: Size(widthDevice * 0.85, 0),
                            ),
                            child: const Text(
                              "Registrarse",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          // Espaciado
                          const SizedBox(
                            height: 20,
                          ),
                          // Iniciar sesión
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ya tienes cuenta? ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Inicia sesión',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? validaCorreo(String email) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern.toString());

    if (regExp.hasMatch(email)) {
      return '1';
    } else {
      return '0';
    }
  }

  void _signUp() async {
    nuevoUsuario.usuario = userController.text;
    nuevoUsuario.correo = mailController.text;
    nuevoUsuario.password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(nuevoUsuario);

    print("Este es el usuario");
    print(user);

    if (user != null) {
      print("Usuario registrado");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ));
    } else {
      print("Ocurrio un error al registrar");
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: 'Usuario ya registrado',
        description: 'Parece que ese correo ya ha sido registrado antes.',
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
        animationBuilder: (
          context,
          animation,
          alignment,
          child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: lowModeShadow,
        dragToClose: true,
      );
    }
  }
}

class Label extends StatelessWidget {
  final String texto;
  const Label({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            texto,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
