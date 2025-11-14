import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

/// Handles file storage operations for photos and audio
class StorageService {
  static const _uuid = Uuid();

  /// Get the app's documents directory
  Future<Directory> getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Save an image file and return the filename
  Future<String> saveImageFile(File sourceFile) async {
    final docsDir = await getDocumentsDirectory();
    final extension = p.extension(sourceFile.path);
    final filename = '${_uuid.v4()}$extension';
    final targetPath = p.join(docsDir.path, filename);
    
    await sourceFile.copy(targetPath);
    return filename;
  }

  /// Get the full path for a stored image filename
  Future<String> getImagePath(String filename) async {
    final docsDir = await getDocumentsDirectory();
    return p.join(docsDir.path, filename);
  }

  /// Delete an image file
  Future<void> deleteImageFile(String filename) async {
    final path = await getImagePath(filename);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Generate a unique filename for audio recording
  String generateAudioFilename() {
    return '${_uuid.v4()}.aac';
  }

  /// Get the full path for storing an audio file
  Future<String> getAudioPath(String filename) async {
    final docsDir = await getDocumentsDirectory();
    return p.join(docsDir.path, filename);
  }

  /// Delete an audio file
  Future<void> deleteAudioFile(String filename) async {
    final path = await getAudioPath(filename);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Check if a file exists
  Future<bool> fileExists(String filename) async {
    final docsDir = await getDocumentsDirectory();
    final path = p.join(docsDir.path, filename);
    return await File(path).exists();
  }
}
