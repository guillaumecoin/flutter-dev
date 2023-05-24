import 'dart:convert';

import 'package:arosaje/class/user.dart';
import 'package:arosaje/component/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'accueil.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String jwt = "";

  Future<void> _submitForm(BuildContext context) async {
    //récupération des informations du formulaire
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    print("1 $email $password");
    final response = await http.post(
      Uri.parse(Config.apiAdress + '/users/login'),
    //  Uri.parse('http://10.0.2.2:3000/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email, 'password': password
      }),
    );

    print(response.body);
    dynamic body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Connexion réussie, vous pouvez rediriger l'utilisateur vers une nouvelle page ou effectuer une action supplémentaire.
      print('Connexion réussie');

      jwt = body["jwt"];
      if(jwt.isEmpty){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            height: 90,
            padding: EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,

                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Error",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text("Failed to retrieve token",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0 ,
        ));

        return;
      }
      print('JWT set to $jwt');

      Future.delayed(Duration(seconds: 3), () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Accueil()),
        )
      });


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 90,
          padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.lightGreen,

              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Success!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text("successfully connected!",
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0 ,
      ));
    } else {
      // Connexion échouée
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 90,
          padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
              
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Error",
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(body["message"],
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0 ,
      ));
      
      print(response.statusCode);
      print(response.body);
      print('Échec de la connexion');
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez saisir votre nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _submitForm(context);
                  }
                },
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
