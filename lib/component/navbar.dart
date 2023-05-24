import 'package:arosaje/pages/accueil.dart';
import 'package:arosaje/pages/ajouterPhoto.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50.0,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
              );
              // Action when button is pressed
            },
            child: Text('Accueil'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
              );
              // Action when button is pressed
            },
            child: Text('Ajouter une plante'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AjouterPhoto()),
              );
              // Action when button is pressed
            },
            child: Text('Autre'),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final String routeName;

  NavBarItem(this.title, this.routeName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
