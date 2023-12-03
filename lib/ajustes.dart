// ignore_for_file: unused_local_variable, deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/firebase_funciones.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:proyecto_movil/utils/singleton.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  final Singleton singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;
    double appbarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
        backgroundColor: Singleton().darkMode ? bgColorLight : bgColorDark,
        appBar: AppBar(
          backgroundColor: Singleton().darkMode ? bgColorLight : bgColorDark,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.menu,
                  color: rojoApp,
                  size: 45,
                ),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                "Ajustes",
                style: TextStyle(
                    color:
                        Singleton().darkMode ? fontColorDark : fontColorLight,
                    fontSize: 36,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        drawer: const DrawerApp(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  // Botón Modo Oscuro
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Modo oscuro',
                          style: TextStyle(
                            color: singleton.darkMode
                                ? fontColorDark
                                : fontColorLight,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          value: singleton.darkMode,
                          onChanged: (value) {
                            Singleton().toggleDarkMode();
                            singleton.darkMode = value;
                            setState(() {});
                          },
                          activeTrackColor: rojoApp,
                          activeColor: grisApp,
                        ),
                      ],
                    ),
                  ),
                  MyDropdownMenu(singleton: singleton),
                ],
              ),
            ],
          ),
        ));
  }
}

class MyDropdownMenu extends StatefulWidget {
  final Singleton singleton;

  const MyDropdownMenu({required this.singleton});

  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  bool _isExpanded = false;

  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();

  bool _validarCorreo = false;
  bool _validarContrasena = false;
  bool _validarUsuario = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Editar usuario',
                    style: TextStyle(
                        color: widget.singleton.darkMode
                            ? fontColorDark
                            : fontColorLight,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: widget.singleton.darkMode
                      ? fontColorDark
                      : fontColorLight,
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Column(
              children: [
                // Usuario
                TextFormField(
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
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0x8C848480),
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 20,
                          color: Color(0x8C848480),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                const SizedBox(height: 15),
                // Correo
                TextFormField(
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
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0x8C848480),
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 20,
                          color: Color(0x8C848480),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                const SizedBox(height: 15),
                // Contraseña
                TextFormField(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 132, 132, 128),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: passwordController,
                    textAlign: TextAlign.left,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0x8C848480),
                            style: BorderStyle.solid,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0x8C848480),
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
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
                          color: Color.fromARGB(255, 132, 132, 128),
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Botón Aceptar
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _validarCorreo = mailController.text.isNotEmpty &&
                                    validaCorreo(mailController.text) == '1'
                                ? false
                                : true;

                            _validarContrasena =
                                passwordController.text.length >= 6 &&
                                        passwordController.text.isNotEmpty
                                    ? false
                                    : true;

                            _validarUsuario =
                                userController.text.isNotEmpty ? false : true;

                            if (!_validarCorreo &&
                                !_validarContrasena &&
                                !_validarUsuario) {
                              // Acción para actualizar datos
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: rojoApp, // Fondo rojo para el botón Aceptar
                          onPrimary: Colors
                              .white, // Texto blanco para el botón Aceptar
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Bordes redondeados
                          ),
                        ),
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Separación entre los botones
                    // Botón Cancelar
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _resetFields();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .white, // Fondo blanco para el botón Cancelar
                          onPrimary:
                              grisApp, // Texto gris para el botón Cancelar
                          side: const BorderSide(color: grisApp), // Borde gris
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Bordes redondeados
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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

  // Función para referescar formulario y cerrar menú al oprimir cancelar
  void _resetFields() {
    mailController.clear();
    passwordController.clear();
    userController.clear();

    _validarCorreo = false;
    _validarContrasena = false;
    _validarUsuario = false;
    setState(() {
      _isExpanded = false;
    });
  }
}
