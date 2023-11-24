import 'package:flutter/material.dart';
import 'package:proyecto_movil/ajustes.dart';
import 'package:proyecto_movil/bookmarks.dart';
import 'package:proyecto_movil/home.dart';
import 'package:proyecto_movil/login.dart';
import 'package:proyecto_movil/mapa.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  // Singleton singleton = Singleton();

  TextStyle listItemStyle = const TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans');

  double listIconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: verdeApp,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home, size: listIconSize),
                  iconColor: Colors.white,
                  title: Text(
                    'Inicio',
                    style: listItemStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(Icons.location_on_rounded, size: listIconSize),
                  iconColor: Colors.white,
                  title: Text('Mapa', style: listItemStyle),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Mapa(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(Icons.bookmark, size: listIconSize),
                  iconColor: Colors.white,
                  title: Text('Mis Lugares', style: listItemStyle),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Bookmark(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(Icons.settings, size: listIconSize),
                  iconColor: Colors.white,
                  title: Text('Ajustes', style: listItemStyle),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Ajustes(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  },
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}