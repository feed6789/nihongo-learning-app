// lib/features/vocabulary/data/datasources/vocabulary_remote_datasource.dart

import '../../../../core/services/supabase_service.dart';
import '../models/vocabulary_model.dart';

class VocabularyRemoteDatasource {
  final _client = SupabaseService.client;

  Future<List<VocabularyModel>> getAll() async {
    final response = await _client.from('vocabulary').select().order('id');

    return (response as List).map((e) => VocabularyModel.fromJson(e)).toList();
  }

  Future<void> insert(VocabularyModel vocab) async {
    await _client.from('vocabulary').insert(vocab.toJson());
  }

  Future<void> update(int id, VocabularyModel vocab) async {
    await _client.from('vocabulary').update(vocab.toJson()).eq('id', id);
  }

  Future<void> delete(int id) async {
    await _client.from('vocabulary').delete().eq('id', id);
  }
}
