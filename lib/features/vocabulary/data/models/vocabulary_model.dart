// lib/features/vocabulary/data/models/vocabulary_model.dart
import 'vocabulary.dart';

class VocabularyModel {
  final int id;
  final int categoryId;
  final String kanji;
  final String hiragana;
  final String romaji;
  final String wordType;
  final String meaningVn;
  final String meaningEn;
  final bool isFavorite;
  final bool isLearned;

  VocabularyModel({
    required this.id,
    required this.categoryId,
    required this.kanji,
    required this.hiragana,
    required this.romaji,
    required this.wordType,
    required this.meaningVn,
    required this.meaningEn,
    required this.isFavorite,
    required this.isLearned,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) {
    // Logic mới: Kiểm tra xem có dữ liệu progress (kết quả của phép Join) không
    // Supabase trả về relation dưới dạng List. Ví dụ: user_vocabulary_progress: [{...}]
    bool favorite = false;
    bool learned = false;

    if (json['user_vocabulary_progress'] != null &&
        (json['user_vocabulary_progress'] as List).isNotEmpty) {
      final progress = (json['user_vocabulary_progress'] as List).first;
      // Map field từ DB schema (favorite, learned) sang Dart model (isFavorite, isLearned)
      favorite = progress['favorite'] ?? false;
      learned = progress['learned'] ?? false;
    }
    // Fallback: Nếu không có bảng phụ, giữ logic cũ (cho trường hợp admin view hoặc bảng vocabulary cũ)
    else {
      favorite = json['is_favorite'] ?? false;
      learned = json['is_learned'] ?? false;
    }

    return VocabularyModel(
      id: json['id'],
      categoryId: json['category_id'],
      kanji: json['kanji'] ?? '',
      hiragana: json['hiragana'] ?? '',
      romaji: json['romaji'] ?? '',
      wordType: json['word_type'] ?? '',
      meaningVn: json['meaning_vn'] ?? '',
      meaningEn: json['meaning_en'] ?? '',
      isFavorite: favorite,
      isLearned: learned,
    );
  }

  // toJson này chủ yếu dùng khi insert từ vựng mới (Admin), không dùng để update progress
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'kanji': kanji,
      'hiragana': hiragana,
      'romaji': romaji,
      'word_type': wordType,
      'meaning_vn': meaningVn,
      'meaning_en': meaningEn,
      // Lưu ý: Khi insert vocab mới, các field này có thể không cần thiết nếu DB đã tách bảng
      'is_favorite': isFavorite,
      'is_learned': isLearned,
    };
  }

  Vocabulary toEntity() {
    return Vocabulary(
      id: id,
      categoryId: categoryId,
      kanji: kanji,
      hiragana: hiragana,
      romaji: romaji,
      meaningEn: meaningEn,
      meaningVn: meaningVn,
      isFavorite: isFavorite,
      isLearned: isLearned,
    );
  }
}
