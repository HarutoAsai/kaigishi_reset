import 'package:flutter/material.dart';
import '../models/question.dart';
import '../widgets/question_card.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  const QuizPage({super.key, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  bool answered = false;
  bool lastCorrect = false;

  void _onAnswered(bool isCorrect) {
    setState(() {
      answered = true;
      lastCorrect = isCorrect;
    });
  }

  void _next() {
    if (index < widget.questions.length - 1) {
      setState(() {
        index++;
        answered = false;
        lastCorrect = false;
      });
    } else {
      _finish();
    }
  }

  void _finish() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('終了'),
        content: const Text('お疲れさま！全問解きました。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('ホームへ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        title: Text('第${q.grade}級 - ${q.topicId}  ${index + 1}/${widget.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: QuestionCard(
              key: ValueKey(q.id),   // ← 次の問題で state 持ち越しを防止
              question: q,
              onAnswered: _onAnswered,
            ),
          ),
          const SizedBox(height: 12),
          if (answered)
            Text(
              lastCorrect ? '⭕ 正解！' : '❌ 不正解…',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: lastCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: answered ? _next : null,
              child: Text(index == widget.questions.length - 1 ? '結果' : '次へ'),
            ),
          ),
        ]),
      ),
    );
  }
}
