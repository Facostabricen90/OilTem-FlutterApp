/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnImageSelected = Function(File imageFile);

class ImagePickerWidget extends StatelessWidget {
  final File imageFile;
  final OnImageSelected onImageSelected;

  ImagePickerWidget({@required this.imageFile, @required this.onImageSelected});

  ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf6d6bd),
              Color.fromARGB(255, 192, 192, 192),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          image: imageFile != null
              ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover)
              : null),
      child: IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: (() {
          _showPickerOptions(context);
        }),
        iconSize: 90,
        color: Colors.white,
      ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camara"),
              onTap: () {
                Navigator.pop(context);
                _showPickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Galería"),
              onTap: () {
                Navigator.pop(context);
                _showPickImage(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPickImage(BuildContext context, camera) async {
    var image = await ImagePicker.pickImage(source: source);
    onImageSelected(image);
  }
}
*/