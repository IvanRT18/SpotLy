// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/firebase_funciones.dart';
import 'package:proyecto_movil/models/ubicacion.dart';
import 'package:proyecto_movil/utils/constantes.dart';
import 'package:proyecto_movil/utils/singleton.dart';
import 'package:toastification/toastification.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Singleton singleton = Singleton();

  late GoogleMapController mapController;

  late final LatLng _center =
      const LatLng(22.144695795592572, -101.0163329857406);

  late Ubicacion nuevaUbicacion = Ubicacion();

  List<Marker> _marker = [];
  List<Marker> _list = [];

  @override
  void initState() {
    getMarkers();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future getMarkers() async {
    getLugares().then(
      (Localizaciones) {
        for (var Localizacion in Localizaciones) {
          print("DENTRO DE INIT");
          // print(Localizacion['uid']);
          // print(Localizacion['latitud']);
          print(Localizacion['nombre_lugar']);

          _list.add(
            new Marker(
              markerId: MarkerId(Localizacion['uid']),
              position:
                  LatLng(Localizacion['latitud'], Localizacion['longitud']),
              infoWindow: InfoWindow(
                title: Localizacion['nombre_lugar'],
              ),
            ),
          );

          // print(_list.length);
        }
        _marker.addAll(_list);
        print("MARKER");
        print(_marker);
        setState(() {});
      },
    );

    // return _marker;
  }

  //Obtiene las coordenadas de la ubicación del dispositivo
  Future<Position> getCurretLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Los servicios de localizacion están desactivados.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permisos de localización negados");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Los permisos de localización estan negados, no se puede procesar la solicitud");
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;
    double appbarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    TextEditingController nombre = TextEditingController();
    TextEditingController descripcion = TextEditingController();
    late double calificacion = 3;

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
            child: Image(
              image: AssetImage(Singleton().darkMode
                  ? 'assets/images/spotlyLogo.png'
                  : 'assets/images/spotlyLogo_darkmode.png'),
              width: 120,
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: SizedBox(
              height: orientation == Orientation.portrait
                  ? heightDevice - appbarHeight
                  : widthDevice - appbarHeight,
              child: Column(
                children: [
                  SizedBox(
                    width: widthDevice * 7,
                    height: heightDevice * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: heightDevice * 0.6,
                            widthFactor: widthDevice * 0.7,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              //Posicion inicial del mapa
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 14.5,
                              ),
                              markers: Set<Marker>.of(_marker),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                        onPressed: () {
                          getCurretLocation().then(
                            (localizacionActual) {
                              nuevaUbicacion.latitud =
                                  localizacionActual.latitude;
                              nuevaUbicacion.longitud =
                                  localizacionActual.longitude;

                              showDialog<String>(
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: AlertDialog(
                                    backgroundColor: Singleton().darkMode
                                        ? bgColorLight
                                        : bgColorDark,
                                    title: Text(
                                      "Agregar ubicación",
                                      style: TextStyle(
                                        color: Singleton().darkMode
                                            ? fontColorDark
                                            : fontColorLight,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            'Escribe la información de la nueva ubicación',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Singleton().darkMode
                                                    ? fontColorDark
                                                    : fontColorLight),
                                          ),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                          controller: nombre,
                                          obscureText: false,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Singleton().darkMode
                                                ? rojoApp
                                                : rojoAppDark,
                                            hintText: "Nombre",
                                            hintStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onChanged: (texto) {
                                            setState(() {
                                              if (texto.trim().isEmpty) {}
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          maxLines: 5,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                          controller: descripcion,
                                          obscureText: false,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Singleton().darkMode
                                                ? rojoApp
                                                : rojoAppDark,
                                            hintText: "Descripcion",
                                            hintStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onChanged: (texto) {
                                            setState(() {
                                              if (texto.trim().isEmpty) {}
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        RatingBar.builder(
                                          initialRating: 3,
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
                                            calificacion = rating;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, "Cancelar"),
                                        child: Text(
                                          "Cancelar",
                                          style: TextStyle(
                                              color: Singleton().darkMode
                                                  ? fontColorDark
                                                  : fontColorLight),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          nuevaUbicacion.descripcion =
                                              descripcion.text;
                                          nuevaUbicacion.nombreUbicacion =
                                              nombre.text;
                                          nuevaUbicacion.calificacion =
                                              calificacion;
                                          print('Nueva ubicacion valores:');
                                          print(nuevaUbicacion.nombreUbicacion);
                                          print(nuevaUbicacion.descripcion);
                                          print(nuevaUbicacion.calificacion);
                                          print(nuevaUbicacion.latitud);
                                          print(nuevaUbicacion.longitud);

                                          await addLugar(nuevaUbicacion).then(
                                            (value) => {
                                              Navigator.pop(context, "Agregar"),
                                              toastification.show(
                                                context: context,
                                                type:
                                                    ToastificationType.success,
                                                style: ToastificationStyle.flat,
                                                title: 'Ubicación guardada',
                                                description:
                                                    'Se ha guardado en "Mis Lugares"',
                                                alignment: Alignment.topLeft,
                                                autoCloseDuration:
                                                    const Duration(seconds: 4),
                                                animationBuilder: (
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
                                                boxShadow: lowModeShadow,
                                                showProgressBar: true,
                                                dragToClose: true,
                                              ),
                                            },
                                          );
                                        },
                                        child: Text("Agregar",
                                            style: TextStyle(
                                                color: Singleton().darkMode
                                                    ? fontColorDark
                                                    : fontColorLight)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidHeart,
                              size: 35,
                              color: rojoApp,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Guardar ubicación",
                              style: TextStyle(
                                  color: rojoApp,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
