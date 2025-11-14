import 'package:flutter/foundation.dart';
import '../models/database.dart';

/// Manages photos list and database operations
class PhotosProvider with ChangeNotifier {
  final AppDatabase _database;
  List<Photo> _photos = [];
  bool _isLoading = false;
  String? _error;

  PhotosProvider(this._database) {
    _loadPhotos();
  }

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load all photos from database
  Future<void> _loadPhotos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _photos = await _database.getAllPhotos();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new photo
  Future<void> addPhoto(PhotosCompanion photo) async {
    try {
      await _database.insertPhoto(photo);
      await _loadPhotos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Update an existing photo
  Future<void> updatePhoto(Photo photo) async {
    try {
      await _database.updatePhoto(photo);
      await _loadPhotos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Delete a photo
  Future<void> deletePhoto(String id) async {
    try {
      await _database.deletePhoto(id);
      await _loadPhotos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Refresh photos list
  Future<void> refresh() async {
    await _loadPhotos();
  }
}
