import '../sources/firebase_storage.dart';

class ImageRepository {
  final FirebaseStorageSource _storageSource;
  const

  ImageRepository(this._storageSource);

  Future<String> fetchImageURL(String imageId) {
    return _storageSource.getImageURL(imageId);
  }
}