import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_movil/drawer.dart';
import 'package:proyecto_movil/utils/constantes.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController mapController;

  late LatLng _center = const LatLng(22.144695795592572, -101.0163329857406);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    final double heightDevice = MediaQuery.of(context).size.height;

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
                color: verdeApp,
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
              "Mapa",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: widthDevice * 0.85,
              height: heightDevice * 0.75,
              child: GoogleMap(
                //creadpr del mapa
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                //Posicion inicial del mapa
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
