import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class accueil extends StatefulWidget {
  const accueil({Key? key}) : super(key: key);


  @override
  _accueilState createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  LatLng position = LatLng(48.8584, 2.2945);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlutterMap(
        options: MapOptions(
          center: position,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );

  }
}


