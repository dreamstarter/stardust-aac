// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageFileNameMeta = const VerificationMeta(
    'imageFileName',
  );
  @override
  late final GeneratedColumn<String> imageFileName = GeneratedColumn<String>(
    'image_file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customAudioFileNameMeta =
      const VerificationMeta('customAudioFileName');
  @override
  late final GeneratedColumn<String> customAudioFileName =
      GeneratedColumn<String>(
        'custom_audio_file_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _selectedVoiceIdMeta = const VerificationMeta(
    'selectedVoiceId',
  );
  @override
  late final GeneratedColumn<String> selectedVoiceId = GeneratedColumn<String>(
    'selected_voice_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateCreatedMeta = const VerificationMeta(
    'dateCreated',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
    'date_created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageFileName,
    label,
    customAudioFileName,
    selectedVoiceId,
    dateCreated,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Photo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_file_name')) {
      context.handle(
        _imageFileNameMeta,
        imageFileName.isAcceptableOrUnknown(
          data['image_file_name']!,
          _imageFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_imageFileNameMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('custom_audio_file_name')) {
      context.handle(
        _customAudioFileNameMeta,
        customAudioFileName.isAcceptableOrUnknown(
          data['custom_audio_file_name']!,
          _customAudioFileNameMeta,
        ),
      );
    }
    if (data.containsKey('selected_voice_id')) {
      context.handle(
        _selectedVoiceIdMeta,
        selectedVoiceId.isAcceptableOrUnknown(
          data['selected_voice_id']!,
          _selectedVoiceIdMeta,
        ),
      );
    }
    if (data.containsKey('date_created')) {
      context.handle(
        _dateCreatedMeta,
        dateCreated.isAcceptableOrUnknown(
          data['date_created']!,
          _dateCreatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      imageFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_file_name'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      customAudioFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_audio_file_name'],
      ),
      selectedVoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_voice_id'],
      ),
      dateCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_created'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class Photo extends DataClass implements Insertable<Photo> {
  final String id;
  final String imageFileName;
  final String label;
  final String? customAudioFileName;
  final String? selectedVoiceId;
  final DateTime dateCreated;
  final int sortOrder;
  const Photo({
    required this.id,
    required this.imageFileName,
    required this.label,
    this.customAudioFileName,
    this.selectedVoiceId,
    required this.dateCreated,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_file_name'] = Variable<String>(imageFileName);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || customAudioFileName != null) {
      map['custom_audio_file_name'] = Variable<String>(customAudioFileName);
    }
    if (!nullToAbsent || selectedVoiceId != null) {
      map['selected_voice_id'] = Variable<String>(selectedVoiceId);
    }
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      imageFileName: Value(imageFileName),
      label: Value(label),
      customAudioFileName: customAudioFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(customAudioFileName),
      selectedVoiceId: selectedVoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedVoiceId),
      dateCreated: Value(dateCreated),
      sortOrder: Value(sortOrder),
    );
  }

  factory Photo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      imageFileName: serializer.fromJson<String>(json['imageFileName']),
      label: serializer.fromJson<String>(json['label']),
      customAudioFileName: serializer.fromJson<String?>(
        json['customAudioFileName'],
      ),
      selectedVoiceId: serializer.fromJson<String?>(json['selectedVoiceId']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageFileName': serializer.toJson<String>(imageFileName),
      'label': serializer.toJson<String>(label),
      'customAudioFileName': serializer.toJson<String?>(customAudioFileName),
      'selectedVoiceId': serializer.toJson<String?>(selectedVoiceId),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Photo copyWith({
    String? id,
    String? imageFileName,
    String? label,
    Value<String?> customAudioFileName = const Value.absent(),
    Value<String?> selectedVoiceId = const Value.absent(),
    DateTime? dateCreated,
    int? sortOrder,
  }) => Photo(
    id: id ?? this.id,
    imageFileName: imageFileName ?? this.imageFileName,
    label: label ?? this.label,
    customAudioFileName: customAudioFileName.present
        ? customAudioFileName.value
        : this.customAudioFileName,
    selectedVoiceId: selectedVoiceId.present
        ? selectedVoiceId.value
        : this.selectedVoiceId,
    dateCreated: dateCreated ?? this.dateCreated,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      imageFileName: data.imageFileName.present
          ? data.imageFileName.value
          : this.imageFileName,
      label: data.label.present ? data.label.value : this.label,
      customAudioFileName: data.customAudioFileName.present
          ? data.customAudioFileName.value
          : this.customAudioFileName,
      selectedVoiceId: data.selectedVoiceId.present
          ? data.selectedVoiceId.value
          : this.selectedVoiceId,
      dateCreated: data.dateCreated.present
          ? data.dateCreated.value
          : this.dateCreated,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('imageFileName: $imageFileName, ')
          ..write('label: $label, ')
          ..write('customAudioFileName: $customAudioFileName, ')
          ..write('selectedVoiceId: $selectedVoiceId, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    imageFileName,
    label,
    customAudioFileName,
    selectedVoiceId,
    dateCreated,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.imageFileName == this.imageFileName &&
          other.label == this.label &&
          other.customAudioFileName == this.customAudioFileName &&
          other.selectedVoiceId == this.selectedVoiceId &&
          other.dateCreated == this.dateCreated &&
          other.sortOrder == this.sortOrder);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<String> imageFileName;
  final Value<String> label;
  final Value<String?> customAudioFileName;
  final Value<String?> selectedVoiceId;
  final Value<DateTime> dateCreated;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.imageFileName = const Value.absent(),
    this.label = const Value.absent(),
    this.customAudioFileName = const Value.absent(),
    this.selectedVoiceId = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String imageFileName,
    required String label,
    this.customAudioFileName = const Value.absent(),
    this.selectedVoiceId = const Value.absent(),
    required DateTime dateCreated,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageFileName = Value(imageFileName),
       label = Value(label),
       dateCreated = Value(dateCreated),
       sortOrder = Value(sortOrder);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<String>? imageFileName,
    Expression<String>? label,
    Expression<String>? customAudioFileName,
    Expression<String>? selectedVoiceId,
    Expression<DateTime>? dateCreated,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageFileName != null) 'image_file_name': imageFileName,
      if (label != null) 'label': label,
      if (customAudioFileName != null)
        'custom_audio_file_name': customAudioFileName,
      if (selectedVoiceId != null) 'selected_voice_id': selectedVoiceId,
      if (dateCreated != null) 'date_created': dateCreated,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? imageFileName,
    Value<String>? label,
    Value<String?>? customAudioFileName,
    Value<String?>? selectedVoiceId,
    Value<DateTime>? dateCreated,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      imageFileName: imageFileName ?? this.imageFileName,
      label: label ?? this.label,
      customAudioFileName: customAudioFileName ?? this.customAudioFileName,
      selectedVoiceId: selectedVoiceId ?? this.selectedVoiceId,
      dateCreated: dateCreated ?? this.dateCreated,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageFileName.present) {
      map['image_file_name'] = Variable<String>(imageFileName.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (customAudioFileName.present) {
      map['custom_audio_file_name'] = Variable<String>(
        customAudioFileName.value,
      );
    }
    if (selectedVoiceId.present) {
      map['selected_voice_id'] = Variable<String>(selectedVoiceId.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('imageFileName: $imageFileName, ')
          ..write('label: $label, ')
          ..write('customAudioFileName: $customAudioFileName, ')
          ..write('selectedVoiceId: $selectedVoiceId, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotosTable photos = $PhotosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [photos];
}

typedef $$PhotosTableCreateCompanionBuilder =
    PhotosCompanion Function({
      required String id,
      required String imageFileName,
      required String label,
      Value<String?> customAudioFileName,
      Value<String?> selectedVoiceId,
      required DateTime dateCreated,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$PhotosTableUpdateCompanionBuilder =
    PhotosCompanion Function({
      Value<String> id,
      Value<String> imageFileName,
      Value<String> label,
      Value<String?> customAudioFileName,
      Value<String?> selectedVoiceId,
      Value<DateTime> dateCreated,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageFileName => $composableBuilder(
    column: $table.imageFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customAudioFileName => $composableBuilder(
    column: $table.customAudioFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedVoiceId => $composableBuilder(
    column: $table.selectedVoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageFileName => $composableBuilder(
    column: $table.imageFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customAudioFileName => $composableBuilder(
    column: $table.customAudioFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedVoiceId => $composableBuilder(
    column: $table.selectedVoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageFileName => $composableBuilder(
    column: $table.imageFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get customAudioFileName => $composableBuilder(
    column: $table.customAudioFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedVoiceId => $composableBuilder(
    column: $table.selectedVoiceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          Photo,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
          Photo,
          PrefetchHooks Function()
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageFileName = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> customAudioFileName = const Value.absent(),
                Value<String?> selectedVoiceId = const Value.absent(),
                Value<DateTime> dateCreated = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                imageFileName: imageFileName,
                label: label,
                customAudioFileName: customAudioFileName,
                selectedVoiceId: selectedVoiceId,
                dateCreated: dateCreated,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageFileName,
                required String label,
                Value<String?> customAudioFileName = const Value.absent(),
                Value<String?> selectedVoiceId = const Value.absent(),
                required DateTime dateCreated,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                imageFileName: imageFileName,
                label: label,
                customAudioFileName: customAudioFileName,
                selectedVoiceId: selectedVoiceId,
                dateCreated: dateCreated,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      Photo,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
      Photo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
}
