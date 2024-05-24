import 'dart:io';

import '../sources/firebase_storage.dart';

class ImageRepository {
  final FirebaseStorageSource _firebaseStorageSource;

  ImageRepository(this._firebaseStorageSource);

  Future<String> uploadImage(File imageFile, String imagePath) async {
    try {
      return await _firebaseStorageSource.uploadImage(imageFile, imagePath);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}