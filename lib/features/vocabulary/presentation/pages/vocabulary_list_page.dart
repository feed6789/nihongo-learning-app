import 'package:flutter/material.dart';

import '../../data/datasources/vocabulary_remote_datasource.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../data/models/vocabulary_model.dart';
import 'vocabulary_form_page.dart';

class VocabularyListPage extends StatefulWidget {
  const VocabularyListPage({super.key});

  @override
  State<VocabularyListPage> createState() => _VocabularyListPageState();
}

class _VocabularyListPageState extends State<VocabularyListPage> {
  late final VocabularyRepository repository;

  @override
  void initState() {
    super.initState();
    repository = VocabularyRepository(VocabularyRemoteDatasource());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary')),
      body: FutureBuilder<List<VocabularyModel>>(
        future: repository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('No vocabulary yet'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final v = items[index];
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
                    setState(() {});
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
                              onPressed: () => Navigator.pop(context, false),
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
                    setState(() {});
                  }
                },
              );
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
}
