import 'package:flutter/material.dart';

import '../../data/datasources/vocabulary_remote_datasource.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../data/models/vocabulary_model.dart';
import 'vocabulary_form_page.dart';
import '../../data/models/vocabulary.dart';

class VocabularyListPage extends StatefulWidget {
  const VocabularyListPage({super.key});

  @override
  State<VocabularyListPage> createState() => _VocabularyListPageState();
}

class _VocabularyListPageState extends State<VocabularyListPage> {
  late final VocabularyRepository repository;
  List<Vocabulary> allList = [];
  List<Vocabulary> filteredList = [];

  int? selectedCategoryId;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    repository = VocabularyRepository(VocabularyRemoteDatasource());
    loadVocabulary();
  }

  Future<void> loadVocabulary() async {
    final items = await repository.getAll();
    allList = items;
    applyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary')),
      body:
          filteredList.isEmpty
              ? const Center(child: Text('No vocabulary yet'))
              : ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final v = filteredList[index];
                  return ListTile(
                    title: Text(v.kanji.isNotEmpty ? v.kanji : v.hiragana),
                    subtitle: Text('${v.meaningEn} / ${v.meaningVn}'),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VocabularyFormPage(vocab: v),
                        ),
                      );

                      if (result == true) {
                        loadVocabulary(); // 👈 reload
                      }
                    },
                    onLongPress: () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Delete'),
                              content: const Text('Delete this vocabulary?'),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                      );

                      if (ok == true) {
                        await repository.delete(v.id);
                        loadVocabulary(); // 👈 reload
                      }
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VocabularyFormPage()),
          );

          if (result == true) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void applyFilter() {
    filteredList =
        allList.where((v) {
          final matchCategory =
              selectedCategoryId == null || v.categoryId == selectedCategoryId;

          final text = searchText.toLowerCase();

          final matchSearch =
              text.isEmpty ||
              v.kanji.toLowerCase().contains(text) ||
              v.hiragana.toLowerCase().contains(text) ||
              v.romaji.toLowerCase().contains(text) ||
              v.meaningEn.toLowerCase().contains(text) ||
              v.meaningVn.toLowerCase().contains(text);

          return matchCategory && matchSearch;
        }).toList();

    setState(() {});
  }
}
