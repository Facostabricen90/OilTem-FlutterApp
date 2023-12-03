// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'take_photo.dart';

class PhotoAvatarWidget extends StatefulWidget {
  Function? action;
  String? photo;
  PhotoAvatarWidget({super.key});

  @override
  State<PhotoAvatarWidget> createState() => _PhotoAvatarWidgetState();
}

class _PhotoAvatarWidgetState extends State<PhotoAvatarWidget> {
  final _pref = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    _pref.then((pref) {
      setState(() {
        widget.photo = pref.getString("photo");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget icono;
    if (widget.photo == null) {
      icono = IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () async {
          var nav = Navigator.of(context);

          final cameras = await availableCameras();
          final camera = cameras.first;

          var imagePath = await nav.push<String>(
            MaterialPageRoute(
              builder: (context) => TakePhotoPage(camera: camera),
            ),
          );

          if (imagePath != null && imagePath.isNotEmpty) {
            setState(() {
              widget.photo = imagePath;
              if (widget.action != null) {
                widget.action!(imagePath);
              }
            });
          }
        },
      );
    } else {
      ImageProvider provider;
      if (widget.photo!.startsWith("http")) {
        provider = NetworkImage(widget.photo!);
      } else {
        provider = FileImage(File(widget.photo!));
      }
      icono = CircleAvatar(
        radius: 30,
        backgroundImage: provider,
      );
    }

    return icono;
  }
}
