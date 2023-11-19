import 'package:flutter/material.dart';
import 'package:proyecto_movil/home.dart';
import 'package:proyecto_movil/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Questrial'),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
