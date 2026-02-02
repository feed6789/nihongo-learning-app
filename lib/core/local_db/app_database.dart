// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

// import 'tables/local_vocab_progress.dart';

// part 'app_database.g.dart';

// @DriftDatabase(tables: [LocalVocabProgress])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());

//   @override
//   int get schemaVersion => 1;

//   Future<LocalVocabProgressData?> getProgress(int vocabId) {
//     return (select(localVocabProgress)
//       ..where((t) => t.vocabId.equals(vocabId))).getSingleOrNull();
//   }

//   Future<void> upsertProgress({
//     required int vocabId,
//     bool? learned,
//     bool? favorite,
//   }) async {
//     final existing = await getProgress(vocabId);

//     await into(localVocabProgress).insertOnConflictUpdate(
//       LocalVocabProgressCompanion(
//         vocabId: Value(vocabId),
//         learned:
//             learned != null
//                 ? Value(learned)
//                 : Value(existing?.learned ?? false),
//         favorite:
//             favorite != null
//                 ? Value(favorite)
//                 : Value(existing?.favorite ?? false),
//       ),
//     );
//   }
// }

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dir.path, 'nihongo_local.db'));
//     return NativeDatabase(file);
//   });
// }
