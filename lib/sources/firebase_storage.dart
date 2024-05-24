import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class FirebaseStorageSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  Future<String> uploadImage(File imageFile, String imagePath) async {
    try {
      _logger.d('Start uploading image to path: $imagePath');
      TaskSnapshot taskSnapshot = await _firebaseStorage.ref().child(imagePath).putFile(imageFile);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      _logger.i('Image uploaded successfully to path: $imagePath');
      _logger.i('Uploaded image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      _logger.e('Error uploading image: $e');
      throw Exception('Error uploading image: $e');
    }
  }
}