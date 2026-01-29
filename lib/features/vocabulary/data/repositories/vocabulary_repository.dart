// lib/features/vocabulary/data/repositories/vocabulary_repository.dart

import '../datasources/vocabulary_remote_datasource.dart';
import '../models/vocabulary_model.dart';
import '../models/vocabulary.dart';

class VocabularyRepository {
  final VocabularyRemoteDatasource datasource;

  VocabularyRepository(this.datasource);

  Future<List<Vocabulary>> getAll() async {
    final models = await datasource.getAll();
    return models.map((e) => e.toEntity()).toList();
  }

  Future<void> add(VocabularyModel vocab) {
    return datasource.insert(vocab);
  }

  Future<void> update(int id, VocabularyModel vocab) {
    return datasource.update(id, vocab);
  }

  Future<void> delete(int id) {
    return datasource.delete(id);
  }

  Future<void> toggleFavorite(int id, bool value) async {
    await datasource.updateFavorite(id, value);
  }

  Future<void> toggleLearned(int id, bool value) async {
    await datasource.updateLearned(id, value);
  }
}
