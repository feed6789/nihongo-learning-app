class Vocabulary {
  final int id;
  final int categoryId;
  final String kanji;
  final String hiragana;
  final String romaji;
  final String meaningVn;
  final String meaningEn;

  Vocabulary({
    required this.id,
    required this.categoryId,
    required this.kanji,
    required this.hiragana,
    required this.romaji,
    required this.meaningVn,
    required this.meaningEn,
  });

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
      id: map['id'],
      categoryId: map['category_id'],
      kanji: map['kanji'] ?? '',
      hiragana: map['hiragana'] ?? '',
      romaji: map['romaji'] ?? '',
      meaningVn: map['meaning_vn'] ?? '',
      meaningEn: map['meaning_en'] ?? '',
    );
  }
}
