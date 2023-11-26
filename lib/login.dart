import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_movil/home.dart';
import 'package:proyecto_movil/mapa.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;

    final userController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 250, child: Placeholder()),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ingresar",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: widthDevice * 0.85,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Color.fromARGB(255, 132, 132, 128),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              controller: passwordController,
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
                                    width: 2,
                                    color: Color(0x8C848480),
                                    style: BorderStyle.solid,
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
                                hintText: "Contraseña",
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 132, 132, 128),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //Iniciar sesión
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Mapa(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: rojoApp,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: rojoApp,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              fixedSize: Size(widthDevice * 0.85, 0),
                            ),
                            child: const Text(
                              "Iniciar sesión",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
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
}
