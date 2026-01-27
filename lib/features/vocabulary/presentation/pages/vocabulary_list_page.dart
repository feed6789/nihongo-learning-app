import 'package:flutter/material.dart';

import '../../data/datasources/vocabulary_remote_datasource.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../data/models/vocabulary_model.dart';

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
              );
            },
          );
        },
      ),
    );
  }
}
