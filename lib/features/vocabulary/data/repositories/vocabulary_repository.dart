// lib/features/vocabulary/data/repositories/vocabulary_repository.dart

import '../datasources/vocabulary_remote_datasource.dart';
import '../datasources/vocabulary_local_datasource.dart';
import '../models/vocabulary_model.dart';
import '../models/vocabulary.dart';

class VocabularyRepository {
  final VocabularyRemoteDatasource remoteDatasource;
  final VocabularyLocalDatasource localDatasource = VocabularyLocalDatasource();

  VocabularyRepository(this.remoteDatasource);

  Future<List<Vocabulary>> getAll() async {
    try {
      // 1. Thử lấy data mới nhất từ Server
      final remoteData = await remoteDatasource.getAll();

      // 2. Lưu vào Local DB (Sync)
      await localDatasource.cacheData(remoteData);

      // 3. Trả về data (có thể trả về remoteData luôn, nhưng lấy từ local để đảm bảo nhất quán)
      return _mapToEntity(remoteData);
    } catch (e) {
      // 4. Nếu lỗi mạng/offline -> Lấy từ Local DB
      print('Offline mode: $e');
      final localData = await localDatasource.getAll();
      return _mapToEntity(localData);
    }
  }

  List<Vocabulary> _mapToEntity(List<VocabularyModel> models) {
    return models.map((e) => e.toEntity()).toList();
  }

  Future<void> add(VocabularyModel vocab) {
    return remoteDatasource.insert(vocab);
  }

  Future<void> update(int id, VocabularyModel vocab) {
    return remoteDatasource.update(id, vocab);
  }

  Future<void> delete(int id) {
    return remoteDatasource.delete(id);
  }

  Future<void> toggleFavorite(int id, bool value) async {
    await remoteDatasource.updateFavorite(id, value);
  }

  Future<void> toggleLearned(int id, bool value) async {
    await remoteDatasource.updateLearned(id, value);
  }
}
