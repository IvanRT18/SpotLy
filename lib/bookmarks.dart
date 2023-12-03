// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/firebase_funciones.dart';
import 'package:proyecto_movil/models/ubicacion.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:toastification/toastification.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  String dropdownValue = "Dog";

  @override
  Widget build(BuildContext context) {
    TextEditingController nombre = TextEditingController();
    TextEditingController descripcion = TextEditingController();

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
              "Mis Lugares",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getLugares(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("Calificacion mis lugares");
                      print(snapshot.data?[index]['calificacion']);
                      return Card(
                        color: rojoApp,
                        margin: const EdgeInsets.only(
                            bottom: 15, left: 15, right: 15),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data?[index]['nombre_lugar'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data?[index]
                                                ['descripcion'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: snapshot.data?[index]
                                                  ['calificacion']
                                              .toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            child: AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text("Opciones"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Ubicacion nuevaUbicacion = Ubicacion(
                                                          calificacion: snapshot
                                                                  .data?[index]
                                                              ['calificacion'],
                                                          descripcion: snapshot
                                                                  .data?[index]
                                                              ['descripcion'],
                                                          nombreUbicacion: snapshot
                                                                  .data?[index]
                                                              ['nombre_lugar']);
                                                      updateLugar(
                                                          nuevaUbicacion,
                                                          snapshot.data?[index]
                                                              ['uid']);
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: rojoApp,
                                                      elevation: 0,
                                                      fixedSize:
                                                          const Size(100, 40),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Editar",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {},
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: rojoApp,
                                                      elevation: 0,
                                                      fixedSize:
                                                          const Size(100, 40),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Eliminar",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, "Cancelar"),
                                                  child: const Text("Cancelar"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                          FontAwesomeIcons.ellipsisVertical),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
