import '../../../../core/services/supabase_service.dart';
import '../models/category_model.dart';

class CategoryRemoteDatasource {
  final _client = SupabaseService.client;

  Future<List<CategoryModel>> getVocabularyCategories() async {
    final response = await _client
        .from('categories')
        .select()
        .eq('type', 'vocab')
        .order('order_index');

    return (response as List).map((e) => CategoryModel.fromJson(e)).toList();
  }
}
