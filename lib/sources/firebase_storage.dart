import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class FirebaseStorageSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  Future<String> getImageURL(String imageId) async {
    final String imagePath = '$imageId.png';
    _logger.d('Retrieving image URL for imagePath: $imagePath');
    try {
      String imageUrl = await _firebaseStorage.ref().child(imagePath).getDownloadURL();
      _logger.d('Retrieved image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      _logger.e('Error retrieving image URL: $e');
      throw Exception('Error retrieving image URL: $e');
    }
  }
}