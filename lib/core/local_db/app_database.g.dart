// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VocabularyTableTable extends VocabularyTable
    with TableInfo<$VocabularyTableTable, VocabularyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hiraganaMeta = const VerificationMeta(
    'hiragana',
  );
  @override
  late final GeneratedColumn<String> hiragana = GeneratedColumn<String>(
    'hiragana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _romajiMeta = const VerificationMeta('romaji');
  @override
  late final GeneratedColumn<String> romaji = GeneratedColumn<String>(
    'romaji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _meaningVnMeta = const VerificationMeta(
    'meaningVn',
  );
  @override
  late final GeneratedColumn<String> meaningVn = GeneratedColumn<String>(
    'meaning_vn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _meaningEnMeta = const VerificationMeta(
    'meaningEn',
  );
  @override
  late final GeneratedColumn<String> meaningEn = GeneratedColumn<String>(
    'meaning_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isLearnedMeta = const VerificationMeta(
    'isLearned',
  );
  @override
  late final GeneratedColumn<bool> isLearned = GeneratedColumn<bool>(
    'is_learned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_learned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    kanji,
    hiragana,
    romaji,
    meaningVn,
    meaningEn,
    isFavorite,
    isLearned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    }
    if (data.containsKey('hiragana')) {
      context.handle(
        _hiraganaMeta,
        hiragana.isAcceptableOrUnknown(data['hiragana']!, _hiraganaMeta),
      );
    }
    if (data.containsKey('romaji')) {
      context.handle(
        _romajiMeta,
        romaji.isAcceptableOrUnknown(data['romaji']!, _romajiMeta),
      );
    }
    if (data.containsKey('meaning_vn')) {
      context.handle(
        _meaningVnMeta,
        meaningVn.isAcceptableOrUnknown(data['meaning_vn']!, _meaningVnMeta),
      );
    }
    if (data.containsKey('meaning_en')) {
      context.handle(
        _meaningEnMeta,
        meaningEn.isAcceptableOrUnknown(data['meaning_en']!, _meaningEnMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_learned')) {
      context.handle(
        _isLearnedMeta,
        isLearned.isAcceptableOrUnknown(data['is_learned']!, _isLearnedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      kanji:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}kanji'],
          )!,
      hiragana:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hiragana'],
          )!,
      romaji:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}romaji'],
          )!,
      meaningVn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}meaning_vn'],
          )!,
      meaningEn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}meaning_en'],
          )!,
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_favorite'],
          )!,
      isLearned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_learned'],
          )!,
    );
  }

  @override
  $VocabularyTableTable createAlias(String alias) {
    return $VocabularyTableTable(attachedDatabase, alias);
  }
}

class VocabularyTableData extends DataClass
    implements Insertable<VocabularyTableData> {
  final int id;
  final int categoryId;
  final String kanji;
  final String hiragana;
  final String romaji;
  final String meaningVn;
  final String meaningEn;
  final bool isFavorite;
  final bool isLearned;
  const VocabularyTableData({
    required this.id,
    required this.categoryId,
    required this.kanji,
    required this.hiragana,
    required this.romaji,
    required this.meaningVn,
    required this.meaningEn,
    required this.isFavorite,
    required this.isLearned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['kanji'] = Variable<String>(kanji);
    map['hiragana'] = Variable<String>(hiragana);
    map['romaji'] = Variable<String>(romaji);
    map['meaning_vn'] = Variable<String>(meaningVn);
    map['meaning_en'] = Variable<String>(meaningEn);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_learned'] = Variable<bool>(isLearned);
    return map;
  }

  VocabularyTableCompanion toCompanion(bool nullToAbsent) {
    return VocabularyTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      kanji: Value(kanji),
      hiragana: Value(hiragana),
      romaji: Value(romaji),
      meaningVn: Value(meaningVn),
      meaningEn: Value(meaningEn),
      isFavorite: Value(isFavorite),
      isLearned: Value(isLearned),
    );
  }

  factory VocabularyTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyTableData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      kanji: serializer.fromJson<String>(json['kanji']),
      hiragana: serializer.fromJson<String>(json['hiragana']),
      romaji: serializer.fromJson<String>(json['romaji']),
      meaningVn: serializer.fromJson<String>(json['meaningVn']),
      meaningEn: serializer.fromJson<String>(json['meaningEn']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isLearned: serializer.fromJson<bool>(json['isLearned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'kanji': serializer.toJson<String>(kanji),
      'hiragana': serializer.toJson<String>(hiragana),
      'romaji': serializer.toJson<String>(romaji),
      'meaningVn': serializer.toJson<String>(meaningVn),
      'meaningEn': serializer.toJson<String>(meaningEn),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isLearned': serializer.toJson<bool>(isLearned),
    };
  }

  VocabularyTableData copyWith({
    int? id,
    int? categoryId,
    String? kanji,
    String? hiragana,
    String? romaji,
    String? meaningVn,
    String? meaningEn,
    bool? isFavorite,
    bool? isLearned,
  }) => VocabularyTableData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    kanji: kanji ?? this.kanji,
    hiragana: hiragana ?? this.hiragana,
    romaji: romaji ?? this.romaji,
    meaningVn: meaningVn ?? this.meaningVn,
    meaningEn: meaningEn ?? this.meaningEn,
    isFavorite: isFavorite ?? this.isFavorite,
    isLearned: isLearned ?? this.isLearned,
  );
  VocabularyTableData copyWithCompanion(VocabularyTableCompanion data) {
    return VocabularyTableData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      hiragana: data.hiragana.present ? data.hiragana.value : this.hiragana,
      romaji: data.romaji.present ? data.romaji.value : this.romaji,
      meaningVn: data.meaningVn.present ? data.meaningVn.value : this.meaningVn,
      meaningEn: data.meaningEn.present ? data.meaningEn.value : this.meaningEn,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isLearned: data.isLearned.present ? data.isLearned.value : this.isLearned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTableData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('kanji: $kanji, ')
          ..write('hiragana: $hiragana, ')
          ..write('romaji: $romaji, ')
          ..write('meaningVn: $meaningVn, ')
          ..write('meaningEn: $meaningEn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isLearned: $isLearned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    kanji,
    hiragana,
    romaji,
    meaningVn,
    meaningEn,
    isFavorite,
    isLearned,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyTableData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.kanji == this.kanji &&
          other.hiragana == this.hiragana &&
          other.romaji == this.romaji &&
          other.meaningVn == this.meaningVn &&
          other.meaningEn == this.meaningEn &&
          other.isFavorite == this.isFavorite &&
          other.isLearned == this.isLearned);
}

class VocabularyTableCompanion extends UpdateCompanion<VocabularyTableData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> kanji;
  final Value<String> hiragana;
  final Value<String> romaji;
  final Value<String> meaningVn;
  final Value<String> meaningEn;
  final Value<bool> isFavorite;
  final Value<bool> isLearned;
  const VocabularyTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.kanji = const Value.absent(),
    this.hiragana = const Value.absent(),
    this.romaji = const Value.absent(),
    this.meaningVn = const Value.absent(),
    this.meaningEn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isLearned = const Value.absent(),
  });
  VocabularyTableCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    this.kanji = const Value.absent(),
    this.hiragana = const Value.absent(),
    this.romaji = const Value.absent(),
    this.meaningVn = const Value.absent(),
    this.meaningEn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isLearned = const Value.absent(),
  }) : categoryId = Value(categoryId);
  static Insertable<VocabularyTableData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? kanji,
    Expression<String>? hiragana,
    Expression<String>? romaji,
    Expression<String>? meaningVn,
    Expression<String>? meaningEn,
    Expression<bool>? isFavorite,
    Expression<bool>? isLearned,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (kanji != null) 'kanji': kanji,
      if (hiragana != null) 'hiragana': hiragana,
      if (romaji != null) 'romaji': romaji,
      if (meaningVn != null) 'meaning_vn': meaningVn,
      if (meaningEn != null) 'meaning_en': meaningEn,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isLearned != null) 'is_learned': isLearned,
    });
  }

  VocabularyTableCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? kanji,
    Value<String>? hiragana,
    Value<String>? romaji,
    Value<String>? meaningVn,
    Value<String>? meaningEn,
    Value<bool>? isFavorite,
    Value<bool>? isLearned,
  }) {
    return VocabularyTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      kanji: kanji ?? this.kanji,
      hiragana: hiragana ?? this.hiragana,
      romaji: romaji ?? this.romaji,
      meaningVn: meaningVn ?? this.meaningVn,
      meaningEn: meaningEn ?? this.meaningEn,
      isFavorite: isFavorite ?? this.isFavorite,
      isLearned: isLearned ?? this.isLearned,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (hiragana.present) {
      map['hiragana'] = Variable<String>(hiragana.value);
    }
    if (romaji.present) {
      map['romaji'] = Variable<String>(romaji.value);
    }
    if (meaningVn.present) {
      map['meaning_vn'] = Variable<String>(meaningVn.value);
    }
    if (meaningEn.present) {
      map['meaning_en'] = Variable<String>(meaningEn.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isLearned.present) {
      map['is_learned'] = Variable<bool>(isLearned.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('kanji: $kanji, ')
          ..write('hiragana: $hiragana, ')
          ..write('romaji: $romaji, ')
          ..write('meaningVn: $meaningVn, ')
          ..write('meaningEn: $meaningEn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isLearned: $isLearned')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VocabularyTableTable vocabularyTable = $VocabularyTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [vocabularyTable];
}

typedef $$VocabularyTableTableCreateCompanionBuilder =
    VocabularyTableCompanion Function({
      Value<int> id,
      required int categoryId,
      Value<String> kanji,
      Value<String> hiragana,
      Value<String> romaji,
      Value<String> meaningVn,
      Value<String> meaningEn,
      Value<bool> isFavorite,
      Value<bool> isLearned,
    });
typedef $$VocabularyTableTableUpdateCompanionBuilder =
    VocabularyTableCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> kanji,
      Value<String> hiragana,
      Value<String> romaji,
      Value<String> meaningVn,
      Value<String> meaningEn,
      Value<bool> isFavorite,
      Value<bool> isLearned,
    });

class $$VocabularyTableTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hiragana => $composableBuilder(
    column: $table.hiragana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get romaji => $composableBuilder(
    column: $table.romaji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaningVn => $composableBuilder(
    column: $table.meaningVn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaningEn => $composableBuilder(
    column: $table.meaningEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VocabularyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hiragana => $composableBuilder(
    column: $table.hiragana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get romaji => $composableBuilder(
    column: $table.romaji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaningVn => $composableBuilder(
    column: $table.meaningVn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaningEn => $composableBuilder(
    column: $table.meaningEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabularyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get hiragana =>
      $composableBuilder(column: $table.hiragana, builder: (column) => column);

  GeneratedColumn<String> get romaji =>
      $composableBuilder(column: $table.romaji, builder: (column) => column);

  GeneratedColumn<String> get meaningVn =>
      $composableBuilder(column: $table.meaningVn, builder: (column) => column);

  GeneratedColumn<String> get meaningEn =>
      $composableBuilder(column: $table.meaningEn, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLearned =>
      $composableBuilder(column: $table.isLearned, builder: (column) => column);
}

class $$VocabularyTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyTableTable,
          VocabularyTableData,
          $$VocabularyTableTableFilterComposer,
          $$VocabularyTableTableOrderingComposer,
          $$VocabularyTableTableAnnotationComposer,
          $$VocabularyTableTableCreateCompanionBuilder,
          $$VocabularyTableTableUpdateCompanionBuilder,
          (
            VocabularyTableData,
            BaseReferences<
              _$AppDatabase,
              $VocabularyTableTable,
              VocabularyTableData
            >,
          ),
          VocabularyTableData,
          PrefetchHooks Function()
        > {
  $$VocabularyTableTableTableManager(
    _$AppDatabase db,
    $VocabularyTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$VocabularyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$VocabularyTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VocabularyTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> kanji = const Value.absent(),
                Value<String> hiragana = const Value.absent(),
                Value<String> romaji = const Value.absent(),
                Value<String> meaningVn = const Value.absent(),
                Value<String> meaningEn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
              }) => VocabularyTableCompanion(
                id: id,
                categoryId: categoryId,
                kanji: kanji,
                hiragana: hiragana,
                romaji: romaji,
                meaningVn: meaningVn,
                meaningEn: meaningEn,
                isFavorite: isFavorite,
                isLearned: isLearned,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                Value<String> kanji = const Value.absent(),
                Value<String> hiragana = const Value.absent(),
                Value<String> romaji = const Value.absent(),
                Value<String> meaningVn = const Value.absent(),
                Value<String> meaningEn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
              }) => VocabularyTableCompanion.insert(
                id: id,
                categoryId: categoryId,
                kanji: kanji,
                hiragana: hiragana,
                romaji: romaji,
                meaningVn: meaningVn,
                meaningEn: meaningEn,
                isFavorite: isFavorite,
                isLearned: isLearned,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VocabularyTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyTableTable,
      VocabularyTableData,
      $$VocabularyTableTableFilterComposer,
      $$VocabularyTableTableOrderingComposer,
      $$VocabularyTableTableAnnotationComposer,
      $$VocabularyTableTableCreateCompanionBuilder,
      $$VocabularyTableTableUpdateCompanionBuilder,
      (
        VocabularyTableData,
        BaseReferences<
          _$AppDatabase,
          $VocabularyTableTable,
          VocabularyTableData
        >,
      ),
      VocabularyTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VocabularyTableTableTableManager get vocabularyTable =>
      $$VocabularyTableTableTableManager(_db, _db.vocabularyTable);
}
