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
    return VocabularyModel(
      id: json['id'],
      categoryId: json['category_id'],
      kanji: json['kanji'] ?? '',
      hiragana: json['hiragana'] ?? '',
      romaji: json['romaji'] ?? '',
      wordType: json['word_type'] ?? '',
      meaningVn: json['meaning_vn'] ?? '',
      meaningEn: json['meaning_en'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      isLearned: json['is_learned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'kanji': kanji,
      'hiragana': hiragana,
      'romaji': romaji,
      'word_type': wordType,
      'meaning_vn': meaningVn,
      'meaning_en': meaningEn,
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
