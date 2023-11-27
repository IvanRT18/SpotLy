import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/ubicacion.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController mapController;

  late LatLng _center = const LatLng(22.144695795592572, -101.0163329857406);

  late Ubicacion nuevaUbicacion = Ubicacion();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
    // TextEditingController calificacion = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
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
            child: Image(
              image: AssetImage('assets/images/spotlyLogo.png'),
              width: 120,
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: widthDevice,
          height: heightDevice - appbarHeight,
          child: Column(
            children: [
              Container(
                width: widthDevice * 7,
                height: heightDevice * 0.8,
                child: GoogleMap(
                  //creadpr del mapa
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  //Posicion inicial del mapa
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.5,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("Posicion"),
                      position: _center,
                    ),
                  },
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                        onPressed: () {
                          getCurretLocation().then((value) {
                            nuevaUbicacion.latitud = value.latitude;
                            nuevaUbicacion.longitud = value.longitude;

                            showDialog<String>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Agregar ubicación"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Escribe la información de la nueva ubicación',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
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
                                                BorderRadius.circular(100),
                                            borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: rojoApp,
                                        hintText: "Nombre",
                                        hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        // errorText: _validateUser
                                        //     ? "Debe de escribir un usuario"
                                        //     : null,
                                        // prefixIcon: const Icon(Icons.verified_user),
                                      ),
                                      onChanged: (texto) {
                                        setState(() {
                                          if (texto.trim().isEmpty) {
                                            // _validateUser = false;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
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
                                                BorderRadius.circular(100),
                                            borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: rojoApp,
                                        hintText: "Descripcion",
                                        hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        // errorText: _validateUser
                                        //     ? "Debe de escribir un usuario"
                                        //     : null,
                                        // prefixIcon: const Icon(Icons.verified_user),
                                      ),
                                      onChanged: (texto) {
                                        setState(() {
                                          if (texto.trim().isEmpty) {
                                            // _validateUser = false;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, "Cancelar"),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, "Agregar"),
                                    child: const Text("Agregar"),
                                  ),
                                ],
                              ),
                            );

                            print('Nuevas coordenadas:');
                            print(nuevaUbicacion.latitud);
                            print(nuevaUbicacion.longitud);
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidHeart,
                              size: 35,
                              color: verdeApp,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Guardar ubicación",
                              style: TextStyle(
                                  color: verdeApp,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
