// lib/features/vocabulary/data/repositories/vocabulary_repository.dart

import '../datasources/vocabulary_remote_datasource.dart';
import '../models/vocabulary_model.dart';

class VocabularyRepository {
  final VocabularyRemoteDatasource datasource;

  VocabularyRepository(this.datasource);

  Future<List<VocabularyModel>> getAll() {
    return datasource.getAll();
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
}
