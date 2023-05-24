import 'dart:convert';
import 'dart:io';

import 'package:arosaje/Tools/photoUploader.dart';
import 'package:arosaje/component/Config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AjouterPhoto extends StatefulWidget {
  const AjouterPhoto({Key? key}) : super(key: key);

  @override
  _AjouterPhotoState createState() => _AjouterPhotoState();
}

class _AjouterPhotoState extends State<AjouterPhoto> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _imageFile;
  BuildContext? buildContext;

  Future<void> _takePhoto() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } else {
      ScaffoldMessenger.of(buildContext!).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'Paramètres',
          onPressed: () {
            openAppSettings();
          },
        ),
        content: Container(
          height: 90,
          padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Error",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  'L\'autorisation de la caméra a été refusée.',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ]),
        ),
      ));
    }
  }

  Future<void> _sendPhoto() async {
    if(_imageFile == null) return;
    PhotoUploader.upload(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire avec photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Prendre une photo'),
                ),
              ),
              if (_imageFile != null)
                Center(
                  child: SizedBox(
                    height: 200.0,
                    child: Image.file(_imageFile!),
                  ),
                ),
              if (_imageFile != null)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _sendPhoto,
                    icon: const Icon(Icons.upload),
                    label: const Text('Envoyer la photo'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
