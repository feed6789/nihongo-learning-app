import 'package:drift/drift.dart';

// Đổi tên class thành VocabularyTable để phản ánh đúng dữ liệu
class VocabularyTable extends Table {
  // Map fields tương tự VocabularyModel trên Supabase
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get kanji => text().withDefault(const Constant(''))();
  TextColumn get hiragana => text().withDefault(const Constant(''))();
  TextColumn get romaji => text().withDefault(const Constant(''))();
  TextColumn get meaningVn => text().withDefault(const Constant(''))();
  TextColumn get meaningEn => text().withDefault(const Constant(''))();

  // Progress status
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isLearned => boolean().withDefault(const Constant(false))();

  // Đảm bảo ID khớp với Supabase để sync dễ dàng
  @override
  Set<Column> get primaryKey => {id};
}
