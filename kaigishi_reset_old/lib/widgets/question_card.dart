// lib/widgets/question_card.dart
import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final void Function(bool isCorrect) onAnswered;
  const QuestionCard({super.key, required this.question, required this.onAnswered});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int? selectedIndex;
  bool showExplanation = false;

  @override
  void didUpdateWidget(covariant QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.id != widget.question.id) {
      // 問題が変わったら選択状態をリセット
      selectedIndex = null;
      showExplanation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.question.question, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          ...List.generate(widget.question.choices.length, (index) {
            final choice = widget.question.choices[index];
            final isSelected = selectedIndex == index;
            final isCorrect = widget.question.answerIndex == index;

            Color? tileColor;
            if (selectedIndex != null) {
              if (isSelected && isCorrect) {
                tileColor = Colors.green[100];
              } else if (isSelected && !isCorrect) {
                tileColor = Colors.red[100];
              } else if (isCorrect) {
                tileColor = Colors.green[50];
              }
            }

            return ListTile(
              title: Text(choice),
              tileColor: tileColor,
              onTap: selectedIndex == null
                  ? () {
                      setState(() {
                        selectedIndex = index;
                        showExplanation = true;
                      });
                      widget.onAnswered(isCorrect);
                    }
                  : null,
            );
          }),
          const SizedBox(height: 16),
          if (showExplanation)
            Text("解説: ${widget.question.explanation}", style: const TextStyle(color: Colors.blueGrey)),
        ]),
      ),
    );
  }
}
