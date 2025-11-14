import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Photos table definition
class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get imageFileName => text()();
  TextColumn get label => text()();
  TextColumn get customAudioFileName => text().nullable()();
  TextColumn get selectedVoiceId => text().nullable()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Photos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Get all photos ordered by sortOrder
  Future<List<Photo>> getAllPhotos() async {
    return (select(photos)..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get();
  }

  /// Insert a new photo
  Future<int> insertPhoto(PhotosCompanion photo) async {
    return into(photos).insert(photo);
  }

  /// Update an existing photo
  Future<bool> updatePhoto(Photo photo) async {
    return update(photos).replace(photo);
  }

  /// Delete a photo
  Future<int> deletePhoto(String id) async {
    return (delete(photos)..where((t) => t.id.equals(id))).go();
  }

  /// Get a photo by ID
  Future<Photo?> getPhotoById(String id) async {
    return (select(photos)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Stream all photos for reactive UI updates
  Stream<List<Photo>> watchAllPhotos() {
    return (select(photos)..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'stardust.sqlite'));
    return NativeDatabase(file);
  });
}
