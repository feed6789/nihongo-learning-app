// lib/features/vocabulary/data/datasources/vocabulary_remote_datasource.dart
import '../../../../core/services/supabase_service.dart';
import '../../../../core/ultis/auth_helper.dart'; // Import AuthHelper
import '../models/vocabulary_model.dart';

class VocabularyRemoteDatasource {
  final _client = SupabaseService.client;

  /// Lấy danh sách từ vựng.
  /// Nếu đã login, sẽ kèm theo trạng thái learned/favorite của user đó.
  Future<List<VocabularyModel>> getAll() async {
    final user = AuthHelper.currentUser;

    if (user != null) {
      // CASE 1: Đã Login -> Join với bảng user_vocabulary_progress
      // Cú pháp select: *, tên_bảng_phụ(*)
      final response = await _client
          .from('vocabulary')
          .select('*, user_vocabulary_progress(*)')
          .order('id');

      // Supabase RLS sẽ tự động filter user_vocabulary_progress chỉ trả về row của user hiện tại
      return (response as List)
          .map((e) => VocabularyModel.fromJson(e))
          .toList();
    } else {
      // CASE 2: Guest -> Chỉ lấy bảng vocabulary
      final response = await _client.from('vocabulary').select().order('id');
      return (response as List)
          .map((e) => VocabularyModel.fromJson(e))
          .toList();
    }
  }

  /// Cập nhật trạng thái Favorite (Lưu vào user_vocabulary_progress)
  Future<void> updateFavorite(int vocabId, bool isFavorite) async {
    final user = AuthHelper.currentUser;
    if (user == null) return; // Guest không lưu lên server được

    // Dùng Upsert: Nếu chưa có row thì tạo mới, có rồi thì update
    await _client.from('user_vocabulary_progress').upsert({
      'user_id': user.id,
      'vocabulary_id': vocabId,
      'favorite': isFavorite, // Map đúng tên cột trong DB Schema
      'last_reviewed': DateTime.now().toIso8601String(),
    });
  }

  /// Cập nhật trạng thái Learned (Lưu vào user_vocabulary_progress)
  Future<void> updateLearned(int vocabId, bool isLearned) async {
    final user = AuthHelper.currentUser;
    if (user == null) return;

    await _client.from('user_vocabulary_progress').upsert({
      'user_id': user.id,
      'vocabulary_id': vocabId,
      'learned': isLearned, // Map đúng tên cột trong DB Schema
      'last_reviewed': DateTime.now().toIso8601String(),
    });
  }

  // --- Các hàm Admin (Insert/Update/Delete Vocabulary gốc) giữ nguyên ---

  Future<void> insert(VocabularyModel vocab) async {
    // Hàm này dành cho Admin thêm từ mới vào kho chung
    await _client.from('vocabulary').insert(vocab.toJson());
  }

  Future<void> update(int id, VocabularyModel vocab) async {
    await _client.from('vocabulary').update(vocab.toJson()).eq('id', id);
  }

  Future<void> delete(int id) async {
    await _client.from('vocabulary').delete().eq('id', id);
  }
}
