// lib/core/local_db/app_database.dart
import 'package:drift/drift.dart';
import 'package:nihongo_app/features/vocabulary/data/models/vocabulary_model.dart';
import 'tables/local_vocab_progress.dart';

// --- MAGIC HAPPENS HERE ---
// Mặc định dùng native_db.dart.
// Nhưng nếu chạy trên web (dart.library.html có sẵn), nó sẽ thay thế bằng web_db.dart
import 'native_db.dart' if (dart.library.html) 'web_db.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [VocabularyTable])
class AppDatabase extends _$AppDatabase {
  // Gọi hàm openConnection() -> Nó sẽ tự biết là lấy từ file native hay web
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<VocabularyTableData>> getAll() => select(vocabularyTable).get();

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
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}
