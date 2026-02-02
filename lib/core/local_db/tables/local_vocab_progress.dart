import 'package:drift/drift.dart';

class LocalVocabProgress extends Table {
  IntColumn get vocabId => integer()();
  BoolColumn get learned => boolean().withDefault(const Constant(false))();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {vocabId};
}
