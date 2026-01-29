import 'package:flutter/material.dart';
import 'package:nihongo_app/features/vocabulary/data/models/vocabulary.dart';

import '../../data/models/vocabulary_model.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../data/datasources/vocabulary_remote_datasource.dart';
import '../../data/models/category_model.dart';
import '../../data/datasources/category_remote_datasource.dart';

class VocabularyFormPage extends StatefulWidget {
  final Vocabulary? vocab; // null = create, có = edit

  const VocabularyFormPage({super.key, this.vocab});

  @override
  State<VocabularyFormPage> createState() => _VocabularyFormPageState();
}

class _VocabularyFormPageState extends State<VocabularyFormPage> {
  final _formKey = GlobalKey<FormState>();
  List<CategoryModel> categories = [];
  int? selectedCategoryId;
  late final VocabularyRepository repository;

  final kanjiCtrl = TextEditingController();
  final hiraCtrl = TextEditingController();
  final romajiCtrl = TextEditingController();
  final meaningEnCtrl = TextEditingController();
  final meaningVnCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    repository = VocabularyRepository(VocabularyRemoteDatasource());

    if (widget.vocab != null) {
      kanjiCtrl.text = widget.vocab!.kanji;
      hiraCtrl.text = widget.vocab!.hiragana;
      romajiCtrl.text = widget.vocab!.romaji;
      meaningEnCtrl.text = widget.vocab!.meaningEn;
      meaningVnCtrl.text = widget.vocab!.meaningVn;
    }

    CategoryRemoteDatasource().getVocabularyCategories().then((value) {
      setState(() {
        categories = value;

        if (widget.vocab != null) {
          selectedCategoryId = widget.vocab!.categoryId;
        } else if (categories.isNotEmpty) {
          selectedCategoryId = categories.first.id;
        }
      });
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final vocab = VocabularyModel(
      id: widget.vocab?.id ?? 0,
      categoryId: selectedCategoryId!,
      kanji: kanjiCtrl.text,
      hiragana: hiraCtrl.text,
      romaji: romajiCtrl.text,
      wordType: '',
      meaningEn: meaningEnCtrl.text,
      meaningVn: meaningVnCtrl.text,
      isFavorite: false,
    );

    if (widget.vocab == null) {
      await repository.add(vocab);
    } else {
      await repository.update(widget.vocab!.id, vocab);
    }

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.vocab != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Vocabulary' : 'Add Vocabulary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: selectedCategoryId,
                decoration: const InputDecoration(labelText: 'Category'),
                items:
                    categories
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.title),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategoryId = value;
                  });
                },
                validator: (v) => v == null ? 'Select category' : null,
              ),

              TextFormField(
                controller: kanjiCtrl,
                decoration: const InputDecoration(labelText: 'Kanji'),
              ),
              TextFormField(
                controller: hiraCtrl,
                decoration: const InputDecoration(labelText: 'Hiragana'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: romajiCtrl,
                decoration: const InputDecoration(labelText: 'Romaji'),
              ),
              TextFormField(
                controller: meaningEnCtrl,
                decoration: const InputDecoration(labelText: 'Meaning (EN)'),
              ),
              TextFormField(
                controller: meaningVnCtrl,
                decoration: const InputDecoration(labelText: 'Meaning (VN)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
