import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class LocalStorageServirces {
  final imageStorage = FirebaseStorage.instance;

  Future<void> addImage(String name, File imageFile) async {
    final imageRef = imageStorage.ref().child('images');
    final uploadTask = imageRef.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageRef.getDownloadURL();
    });
  }
}
