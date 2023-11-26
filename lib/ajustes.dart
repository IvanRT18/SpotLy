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
              icon: Icon(
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
      drawer: DrawerApp(),
      body: SizedBox(
        width: widthDevice,
        height: heightDevice,
        child: Column(
          children: [
            // Container(
            //   color: Colors.red,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Text("Obtener usuarios"),
            //   ),
            // ),
            // Column(
            //   children: [
            //     FutureBuilder(
            //       future: getUsuarios(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //             itemCount: snapshot.data?.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Text(snapshot.data?[index]['usuario']);
            //             },
            //           );
            //         } else {
            //           return CircularProgressIndicator();
            //         }
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
