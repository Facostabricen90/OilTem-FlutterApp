import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  late final FirebaseStorage _storage;

  FirebaseStorageRepository() {
    _storage = FirebaseStorage.instanceFor(
        bucket: "gs://mt2022-oiltemp.appspot.com");
  }

  Future<String> loadFile(String filePath, String folder) async {
    final file = File(filePath);

    final index = filePath.lastIndexOf("/") + 1;
    final fileName = filePath.substring(index);

    try {
      final ref = _storage.ref("$folder/$fileName");
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return Future.error("Error cargando archivo: $e");
    }
  }
}
