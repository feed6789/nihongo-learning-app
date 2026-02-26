// lib/features/vocabulary/data/repositories/vocabulary_repository.dart

import '../datasources/vocabulary_remote_datasource.dart';
import '../datasources/vocabulary_local_datasource.dart';
import '../models/vocabulary_model.dart';
import '../models/vocabulary.dart';
import '../../../../core/ultis/auth_helper.dart';

class VocabularyRepository {
  final VocabularyRemoteDatasource remoteDatasource;
  final VocabularyLocalDatasource localDatasource = VocabularyLocalDatasource();

  VocabularyRepository(this.remoteDatasource);

  Future<List<Vocabulary>> getAll() async {
    try {
      // 1. Thử lấy data từ Server (đã bao gồm progress của User nếu có)
      final remoteData = await remoteDatasource.getAll();

      // 2. Nếu User đã login, cache lại vào Local DB để lần sau mở app nhanh hơn
      // Lưu ý: Local DB hiện tại là một bảng phẳng (flat table).
      // Việc lưu đè này giúp Local DB phản ánh đúng trạng thái của User hiện tại.
      if (!AuthHelper.isGuest) {
        await localDatasource.cacheData(remoteData);
      }

      return _mapToEntity(remoteData);
    } catch (e) {
      // 3. Nếu lỗi mạng -> Lấy từ Local DB
      print('Offline mode or Error: $e');
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

  // Toggle Favorite: Cập nhật Server -> Sau đó cập nhật Local (để UI phản hồi nhanh mà ko cần load lại hết)
  Future<void> toggleFavorite(int id, bool value) async {
    // 1. Gửi lên server
    await remoteDatasource.updateFavorite(id, value);

    // 2. (Optional) Cập nhật nhanh vào local DB nếu muốn UI update tức thì khi offline
    // Hiện tại UI đang reload lại list nên chưa cần thiết phải update local lẻ tẻ ở đây.
  }

  Future<void> toggleLearned(int id, bool value) async {
    await remoteDatasource.updateLearned(id, value);
  }
}
