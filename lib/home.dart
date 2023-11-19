import 'package:flutter/material.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: verdeApp,
                size: 45,
              ),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: DrawerApp(),
      body: Stack(
        children: [
          Text("home"),
        ],
      ),
    );
  }
}
