import 'package:flutter/material.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:proyecto_movil/utils/singleton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Singleton singleton = Singleton();

  @override
  Widget build(BuildContext context) {
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
      ),
      drawer: const DrawerApp(),
      body: const Stack(
        children: [
          Text("home"),
        ],
      ),
    );
  }
}
