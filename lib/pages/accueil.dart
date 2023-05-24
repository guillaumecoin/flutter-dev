import 'package:arosaje/class/plant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../component/navbar.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _getPlants();
  }

  void _getPlants() async {
    final response = await http.get(Uri.parse('http://192.168.1.24:3000/plants/'));

    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> parsedJson = jsonDecode(response.body);
        _plants = parsedJson.map((json) => Plant.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load plants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Plants',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Plants'),
        ),
        body: ListView.builder(
          itemCount: _plants.length,
          itemBuilder: (context, index) {
            final plant = _plants[index];
            return ListTile(
              title: Text(plant.name),
              subtitle: Text(plant.description),
            );
          },
        ),
        bottomNavigationBar: Navbar(),
      ),
    );
  }
}




