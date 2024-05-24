import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class FirebaseStorageSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  static const String BASE_PATH = 'gs://englishcards-12845.appspot.com/';

  Future<String> getImageURL(String imageId) async {
    final String imagePath = '$BASE_PATH/$imageId';
    try {
      String imageUrl = await _firebaseStorage.ref().child(imagePath).getDownloadURL();
      _logger.i('Retrieved image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      _logger.e('Error retrieving image URL: $e');
      throw Exception('Error retrieving image URL: $e');
    }
  }
}
