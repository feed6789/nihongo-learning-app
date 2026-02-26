// lib/core/local_db/web_db.dart
import 'package:drift/drift.dart';
// ignore: deprecated_member_use
import 'package:drift/web.dart';

QueryExecutor openConnection() {
  return WebDatabase('nihongo_local');
}
