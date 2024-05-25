import '../sources/firebase_storage.dart';

class ImageRepository {
  final FirebaseStorageSource _firebaseStorageSource = FirebaseStorageSource();

  Future<String> getImageUrl(String imageId) async {
    return _firebaseStorageSource.getImageURL(imageId);
  }
}
