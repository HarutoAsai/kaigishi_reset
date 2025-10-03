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
  Widget build(BuildContext context) {
    final q = widget.question;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(q.question, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          ...List.generate(q.choices.length, (index) {
            final choice = q.choices[index];
            final isSelected = selectedIndex == index;
            final isCorrect = q.answerIndex == index;

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
          const SizedBox(height: 12),
          if (showExplanation)
            Text('解説: ${q.explanation}', style: const TextStyle(color: Colors.blueGrey)),
        ]),
      ),
    );
  }
}
