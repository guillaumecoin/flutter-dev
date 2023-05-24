import 'package:flutter/cupertino.dart';

class Plant {
  final int idPlant;
  final String name;
  final String scientificName;
  final String longitude;
  final String description;
  final String photoUrl;
  final String latitude;

  Plant({required this.idPlant, required this.name,required this.scientificName,required this.longitude,
    required this.description,required this.photoUrl,required this.latitude});




  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        idPlant: json['idPlant'],
        name: json['name'],
        scientificName: json['scientificName'],
        longitude: json['longitude'],
        description: json['description'],
        photoUrl: json['photoUrl'],
        latitude: json['latitude'],
    );
  }
}
