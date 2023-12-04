// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/firebase_funciones.dart';
import 'package:proyecto_movil/models/ubicacion.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:proyecto_movil/utils/singleton.dart';
import 'package:toastification/toastification.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Singleton singleton = Singleton();

  String dropdownValue = "Dog";

  final GlobalKey<FormState> opcionesDialogKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmarEliminarDialogKey =
      GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nombre = TextEditingController();
    TextEditingController descripcion = TextEditingController();
    double nuevaCalificacion = 0;

    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;
    double appbarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    Ubicacion ubicacionSeleccionada = Ubicacion();

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
              "Mis Lugares",
              style: TextStyle(
                  color: Singleton().darkMode ? fontColorDark : fontColorLight,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: getLugares(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Singleton().darkMode ? rojoApp : rojoAppDark,
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
                              //Icono 3 puntos
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        singleton.idSeleccionado =
                                            snapshot.data?[index]['uid'];
                                        singleton.calificacionSeleccionado =
                                            snapshot.data?[index]
                                                ['calificacion'];
                                        singleton.descripcionSeleccionado =
                                            snapshot.data?[index]
                                                ['descripcion'];
                                        singleton.nombreSeleccionado = snapshot
                                            .data?[index]['nombre_lugar'];
                                        singleton.latSeleccionado =
                                            snapshot.data?[index]['latitud'];
                                        singleton.longSeleccionado =
                                            snapshot.data?[index]['longitud'];

                                        print(snapshot
                                            .data?[index]['nombre_lugar']
                                            .runtimeType);
                                        print(snapshot
                                            .data?[index]['calificacion']
                                            .runtimeType);
                                        print(snapshot
                                            .data?[index]['descripcion']
                                            .runtimeType);
                                        print(snapshot.data?[index]['latitud']
                                            .runtimeType);
                                        print(snapshot.data?[index]['longitud']
                                            .runtimeType);
                                        print(snapshot
                                            .data?[index]['uid'].runtimeType);

                                        print("SIngleton valores___________");
                                        print(singleton.idSeleccionado);
                                        print(
                                            singleton.calificacionSeleccionado);
                                        print(
                                            singleton.descripcionSeleccionado);
                                        print(singleton.nombreSeleccionado);

                                        print(singleton.longSeleccionado);
                                        print(singleton.latSeleccionado);
                                        showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              //Alert dialog opciones editar/eliminar
                                              SingleChildScrollView(
                                            child: AlertDialog(
                                              key: opcionesDialogKey,
                                              backgroundColor:
                                                  Singleton().darkMode
                                                      ? bgColorLight
                                                      : bgColorDark,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Opciones",
                                                    style: TextStyle(
                                                      color:
                                                          Singleton().darkMode
                                                              ? fontColorDark
                                                              : fontColorLight,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.close,
                                                        color: Singleton()
                                                                .darkMode
                                                            ? fontColorDark
                                                            : fontColorLight),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, "Cancelar");
                                                    },
                                                  ),
                                                ],
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // Editar
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                //AlertDialog de Editar
                                                                return AlertDialog(
                                                                  backgroundColor: Singleton()
                                                                          .darkMode
                                                                      ? bgColorLight
                                                                      : bgColorDark,
                                                                  title: Text(
                                                                    "Editar ubicación",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Singleton()
                                                                              .darkMode
                                                                          ? fontColorDark
                                                                          : fontColorLight,
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          'Ediat la información de la ubicación',
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Singleton().darkMode ? fontColorDark : fontColorLight),
                                                                        ),
                                                                      ),
                                                                      //Nombre editar
                                                                      TextFormField(
                                                                        // initialValue:
                                                                        //     singleton.nombreSeleccionado,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                        controller:
                                                                            nombre,
                                                                        obscureText:
                                                                            false,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide.none),
                                                                          filled:
                                                                              true,
                                                                          fillColor: Singleton().darkMode
                                                                              ? rojoApp
                                                                              : rojoAppDark,
                                                                          hintText:
                                                                              singleton.nombreSeleccionado,
                                                                          hintStyle: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        onChanged:
                                                                            (texto) {
                                                                          setState(
                                                                              () {
                                                                            if (texto.trim().isEmpty) {}
                                                                          });
                                                                        },
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      //Descipcion editar
                                                                      TextFormField(
                                                                        maxLines:
                                                                            5,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                        controller:
                                                                            descripcion,
                                                                        obscureText:
                                                                            false,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide.none),
                                                                          filled:
                                                                              true,
                                                                          fillColor: Singleton().darkMode
                                                                              ? rojoApp
                                                                              : rojoAppDark,
                                                                          hintText:
                                                                              singleton.descripcionSeleccionado,
                                                                          hintStyle: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        onChanged:
                                                                            (texto) {
                                                                          setState(
                                                                              () {
                                                                            if (texto.trim().isEmpty) {}
                                                                          });
                                                                        },
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      //Estrellas editar
                                                                      RatingBar
                                                                          .builder(
                                                                        initialRating:
                                                                            singleton.calificacionSeleccionado,
                                                                        minRating:
                                                                            1,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                4.0),
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          print(
                                                                              rating);
                                                                          nuevaCalificacion =
                                                                              rating;
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  //AlertDialog editar opciones/acciones
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          "Cancelar"),
                                                                      child:
                                                                          Text(
                                                                        "Cancelar",
                                                                        style: TextStyle(
                                                                            color: Singleton().darkMode
                                                                                ? fontColorDark
                                                                                : fontColorLight),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        print(
                                                                            "Dentro de actualizar");
                                                                        print(singleton
                                                                            .idSeleccionado);
                                                                        await updateLugar(
                                                                                singleton.idSeleccionado,
                                                                                nombre.text,
                                                                                descripcion.text,
                                                                                nuevaCalificacion)
                                                                            .then((value) {
                                                                          print(
                                                                              "Dentro de actualizar otra vez");
                                                                          Navigator.pop(
                                                                              context,
                                                                              "Agregar");

                                                                          toastification
                                                                              .show(
                                                                            context:
                                                                                context,
                                                                            type:
                                                                                ToastificationType.success,
                                                                            style:
                                                                                ToastificationStyle.flat,
                                                                            title:
                                                                                'Ubicación actualizada',
                                                                            description:
                                                                                'Se ha actulizado en "Mis Lugares"',
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            autoCloseDuration:
                                                                                const Duration(seconds: 4),
                                                                            animationBuilder:
                                                                                (
                                                                              context,
                                                                              animation,
                                                                              alignment,
                                                                              child,
                                                                            ) {
                                                                              return ScaleTransition(
                                                                                scale: animation,
                                                                                child: child,
                                                                              );
                                                                            },
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                            boxShadow:
                                                                                lowModeShadow,
                                                                            showProgressBar:
                                                                                true,
                                                                            dragToClose:
                                                                                true,
                                                                          );
                                                                        });

                                                                        setState(
                                                                            () {});
                                                                        // nuevaUbicacion.descripcion =
                                                                        //     descripcion.text;
                                                                        // nuevaUbicacion.nombreUbicacion =
                                                                        //     nombre.text;
                                                                        // nuevaUbicacion.calificacion =
                                                                        //     calificacion;
                                                                        // print(
                                                                        //     'Nueva ubicacion valores:');
                                                                        // print(nuevaUbicacion
                                                                        //     .nombreUbicacion);
                                                                        // print(nuevaUbicacion
                                                                        //     .descripcion);
                                                                        // print(nuevaUbicacion
                                                                        //     .calificacion);
                                                                        // print(nuevaUbicacion
                                                                        //     .latitud);
                                                                        // print(nuevaUbicacion
                                                                        //     .longitud);

                                                                        // await addLugar(nuevaUbicacion)
                                                                        //     .then(
                                                                        //   (value) =>
                                                                        //       {

                                                                        //     toastification.show(
                                                                        //       context: context,
                                                                        //       type: ToastificationType.success,
                                                                        //       style: ToastificationStyle.flat,
                                                                        //       title: 'Ubicación guardada',
                                                                        //       description: 'Se ha guardado en "Mis Lugares"',
                                                                        //       alignment: Alignment.topLeft,
                                                                        //       autoCloseDuration: const Duration(seconds: 4),
                                                                        //       animationBuilder: (
                                                                        //         context,
                                                                        //         animation,
                                                                        //         alignment,
                                                                        //         child,
                                                                        //       ) {
                                                                        //         return ScaleTransition(
                                                                        //           scale: animation,
                                                                        //           child: child,
                                                                        //         );
                                                                        //       },
                                                                        //       borderRadius: BorderRadius.circular(12.0),
                                                                        //       boxShadow: lowModeShadow,
                                                                        //       showProgressBar: true,
                                                                        //       dragToClose: true,
                                                                        //     ),
                                                                        //   },
                                                                        // );
                                                                      },
                                                                      child: Text(
                                                                          "Agregar",
                                                                          style:
                                                                              TextStyle(color: Singleton().darkMode ? fontColorDark : fontColorLight)),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            // Ubicacion
                                                            //     nuevaUbicacion =
                                                            //     Ubicacion(
                                                            //   calificacion: snapshot
                                                            //               .data?[
                                                            //           index][
                                                            //       'calificacion'],
                                                            //   descripcion: snapshot
                                                            //               .data?[
                                                            //           index][
                                                            //       'descripcion'],
                                                            //   nombreUbicacion:
                                                            //       snapshot.data?[
                                                            //               index]
                                                            //           [
                                                            //           'nombre_lugar'],
                                                            // );
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                rojoApp,
                                                            elevation: 0,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    15),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.edit,
                                                                color:
                                                                    fontColorLight,
                                                              ),
                                                              SizedBox(
                                                                  width: 8),
                                                              Text(
                                                                "Editar",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      fontColorLight,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  // Eliminar
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  key:
                                                                      confirmarEliminarDialogKey,
                                                                  backgroundColor: Singleton()
                                                                          .darkMode
                                                                      ? bgColorLight
                                                                      : bgColorDark,
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      // Icono de alerta
                                                                      const Icon(
                                                                        Icons
                                                                            .warning,
                                                                        size:
                                                                            40,
                                                                        color:
                                                                            rojoApp,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      // Texto "Estas seguro?"
                                                                      Text(
                                                                        "¿Estás seguro?",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color: Singleton().darkMode
                                                                                ? fontColorDark
                                                                                : fontColorLight),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      // Texto informativo
                                                                      Text(
                                                                        "Esta acción es irreversible y eliminará toda la información asociada.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Singleton().darkMode
                                                                                ? fontColorDark
                                                                                : fontColorLight),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      // Boton Eliminar
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                // Agrega aquí la lógica para eliminar
                                                                                Navigator.of(context).pop();
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              style: TextButton.styleFrom(
                                                                                backgroundColor: rojoApp,
                                                                                elevation: 0,
                                                                                shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                ),
                                                                              ),
                                                                              child: const Text(
                                                                                "Eliminar",
                                                                                style: TextStyle(
                                                                                  color: fontColorLight,
                                                                                  fontSize: 20,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      // Boton Cancelar
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop(); // Cierra el AlertDialog
                                                                              },
                                                                              style: TextButton.styleFrom(
                                                                                backgroundColor: fontColorLight,
                                                                                elevation: 0,
                                                                                shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                  side: BorderSide(color: grisApp),
                                                                                ),
                                                                              ),
                                                                              child: const Text(
                                                                                "Cancelar",
                                                                                style: TextStyle(
                                                                                  color: rojoApp,
                                                                                  fontSize: 20,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                rojoApp,
                                                            elevation: 0,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    15),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.delete,
                                                                color:
                                                                    fontColorLight,
                                                              ),
                                                              SizedBox(
                                                                  width: 8),
                                                              Text(
                                                                "Eliminar",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      fontColorLight,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
