// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/firebase_funciones.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;
    double appbarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text(
              "Ajustes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              DarkModeToggle(),
              MyDropdownMenu(),
            ],
          ),
        ],
      ),
    );
  }
}

class DarkModeToggle extends StatefulWidget {
  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Modo oscuro',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                // Puedes añadir lógica para cambiar entre modos claro y oscuro aquí
              });
            },
            activeTrackColor: Colors.grey[700],
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

class MyDropdownMenu extends StatefulWidget {
  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  bool _isExpanded = false;

  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();

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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Editar usuario',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(_isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
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
                    errorText: 'Debe de escribir un nombre de usuario válido',
                  ),
                ),
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
                    errorText: 'Debe de escribir un correo válido',
                  ),
                ),
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
                      errorText:
                          'Debe de ser una contraseña mayor a 6 caracteres'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Botón Aceptar
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
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
                    SizedBox(width: 16), // Separación entre los botones
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
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
}
