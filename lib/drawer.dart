import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_movil/ajustes.dart';
import 'package:proyecto_movil/bookmarks.dart';
import 'package:proyecto_movil/login.dart';
import 'package:proyecto_movil/mapa.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:proyecto_movil/utils/singleton.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  Singleton singleton = Singleton();

  TextStyle listItemStyle = const TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans');

  double listIconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Singleton().darkMode ? rojoApp : rojoAppDark,
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
                Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Image(
                    image: AssetImage(Singleton().darkMode
                        ? 'assets/images/spotlyLogo.png'
                        : 'assets/images/spotlyLogo_darkmode.png'),
                    width: 120,
                  ),
                ),
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
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(Icons.home, size: listIconSize),
                  iconColor: Colors.white,
                  title: Text(
                    'Inicio',
                    style: listItemStyle,
                  ),
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
                    FirebaseAuth.instance.signOut().then((value) => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ))
                        });
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
