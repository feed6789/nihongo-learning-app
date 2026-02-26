// lib/features/vocabulary/data/repositories/vocabulary_repository.dart

import '../datasources/vocabulary_remote_datasource.dart';
import '../datasources/vocabulary_local_datasource.dart';
import 'package:flutter/foundation.dart';
import '../models/vocabulary_model.dart';
import '../models/vocabulary.dart';
import '../../../../core/ultis/auth_helper.dart';

class VocabularyRepository {
  final VocabularyRemoteDatasource remoteDatasource;
  final VocabularyLocalDatasource localDatasource = VocabularyLocalDatasource();

  VocabularyRepository(this.remoteDatasource);

  Future<List<Vocabulary>> getAll() async {
    try {
      // 1. Lấy data từ Server (Supabase)
      final remoteData = await remoteDatasource.getAll();

      // 2. Cache vào Local DB (CHỈ LÀM KHI KHÔNG PHẢI WEB)
      // Thêm điều kiện !kIsWeb để chặn lỗi sql.js trên trình duyệt
      if (!kIsWeb && !AuthHelper.isGuest) {
        try {
          await localDatasource.cacheData(remoteData);
        } catch (e) {
          print("Lỗi cache local (không ảnh hưởng hiển thị): $e");
        }
      }

      // 3. Trả về data
      return _mapToEntity(remoteData);
    } catch (e) {
      /// 4. Nếu lỗi mạng/offline -> Lấy từ Local DB (Chỉ áp dụng cho Mobile)
      if (!kIsWeb) {
        print('Offline mode: $e');
        final localData = await localDatasource.getAll();
        return _mapToEntity(localData);
      } else {
        // Nếu là Web mà lỗi mạng thì chịu, ném lỗi ra để UI hiện thông báo
        rethrow;
      }
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
