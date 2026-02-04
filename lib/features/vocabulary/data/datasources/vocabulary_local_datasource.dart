import '../../../../core/local_db/db_instance.dart';
import '../../../../core/local_db/app_database.dart';
import '../models/vocabulary_model.dart';

class VocabularyLocalDatasource {
  Future<List<VocabularyModel>> getAll() async {
    final result = await appDatabase.getAll();
    // Convert Drift Data -> VocabularyModel
    return result
        .map(
          (e) => VocabularyModel(
            id: e.id,
            categoryId: e.categoryId,
            kanji: e.kanji,
            hiragana: e.hiragana,
            romaji: e.romaji,
            wordType:
                '', // Local db chưa lưu field này, tạm để rỗng hoặc thêm vào Table sau
            meaningVn: e.meaningVn,
            meaningEn: e.meaningEn,
            isFavorite: e.isFavorite,
            isLearned: e.isLearned,
          ),
        )
        .toList();
  }

  Future<void> cacheData(List<VocabularyModel> data) async {
    await appDatabase.cacheVocabularies(data);
  }
}
