import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:nihongo_app/features/vocabulary/data/models/vocabulary_model.dart';

import 'tables/local_vocab_progress.dart'; // Import file chứa VocabularyTable

part 'app_database.g.dart';

@DriftDatabase(tables: [VocabularyTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Lấy tất cả từ vựng từ local
  Future<List<VocabularyTableData>> getAll() => select(vocabularyTable).get();

  // Insert hoặc Update danh sách từ vựng từ Server về
  Future<void> cacheVocabularies(List<VocabularyModel> models) async {
    await batch((batch) {
      for (final model in models) {
        batch.insert(
          vocabularyTable,
          VocabularyTableCompanion.insert(
            id: Value(model.id),
            categoryId: model.categoryId,
            kanji: Value(model.kanji),
            hiragana: Value(model.hiragana),
            romaji: Value(model.romaji),
            meaningVn: Value(model.meaningVn),
            meaningEn: Value(model.meaningEn),
            isFavorite: Value(model.isFavorite),
            isLearned: Value(model.isLearned),
          ),
          mode: InsertMode.insertOrReplace, // Quan trọng: Có rồi thì đè lên
        );
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'nihongo_local.db'));
    return NativeDatabase(file);
  });
}
