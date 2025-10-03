import "package:flutter/material.dart";
import "../models/question.dart";
import "choice_tile.dart";

class QuestionCard extends StatefulWidget {
  final Question q;
  final void Function(bool correct) onAnswered;
  const QuestionCard({super.key, required this.q, required this.onAnswered});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int? selected;
  bool locked = false;

  @override
  Widget build(BuildContext context) {
    final q = widget.q;
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8, runSpacing: 8,
              children: [
                Chip(
                  label: Text("第${q.grade}級", style: const TextStyle(fontWeight: FontWeight.w600)),
                  backgroundColor: cs.secondaryContainer,
                ),
                Chip(
                  label: Text(q.topicId),
                  backgroundColor: cs.surfaceContainerHighest,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(q.question, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 14),
            ...List.generate(q.choices.length, (i) {
              final choice = q.choices[i];
              final isCorrect = q.answerIndex == i;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ChoiceTile(
                  text: choice,
                  isSelected: selected == i,
                  isCorrect: isCorrect,
                  locked: locked,
                  onTap: () {
                    setState(() {
                      selected = i;
                      locked = true;
                    });
                    widget.onAnswered(isCorrect);
                  },
                ),
              );
            }),
            const SizedBox(height: 12),
            if (locked) _explanation(q.explanation),
          ],
        ),
      ),
    );
  }

  Widget _explanation(String text) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_book, color: cs.primary),
          const SizedBox(width: 8),
          Expanded(child: Text("解説: $text")),
        ],
      ),
    );
  }
}
