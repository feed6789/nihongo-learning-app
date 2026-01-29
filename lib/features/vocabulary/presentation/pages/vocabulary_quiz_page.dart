import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/models/vocabulary.dart';

class VocabularyQuizPage extends StatefulWidget {
  final List<Vocabulary> vocabList;

  const VocabularyQuizPage({super.key, required this.vocabList});

  @override
  State<VocabularyQuizPage> createState() => _VocabularyQuizPageState();
}

class _VocabularyQuizPageState extends State<VocabularyQuizPage> {
  late Vocabulary current;
  late List<String> options;
  String? selected;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    nextQuestion();
  }

  void nextQuestion() {
    final rnd = Random();

    current = widget.vocabList[rnd.nextInt(widget.vocabList.length)];

    final others =
        widget.vocabList.where((v) => v.id != current.id).toList()..shuffle();

    options = [
      current.meaningEn,
      others[0].meaningEn,
      others[1].meaningEn,
      others[2].meaningEn,
    ]..shuffle();

    selected = null;
    answered = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              current.kanji.isNotEmpty ? current.kanji : current.hiragana,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ...options.map((o) {
              final isCorrect = o == current.meaningEn;
              Color? color;

              if (answered) {
                if (o == selected) {
                  color = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  color = Colors.green;
                }
              }

              return Card(
                color: color,
                child: ListTile(
                  title: Text(o),
                  onTap:
                      answered
                          ? null
                          : () {
                            setState(() {
                              selected = o;
                              answered = true;
                            });
                          },
                ),
              );
            }),

            const Spacer(),

            ElevatedButton(
              onPressed: answered ? nextQuestion : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
