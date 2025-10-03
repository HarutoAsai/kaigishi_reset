import "package:flutter/material.dart";
import "../models/question.dart";
import "../widgets/question_card.dart";

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  const QuizPage({super.key, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int idx = 0;
  int correct = 0;
  bool answered = false;
  bool lastCorrect = false;

  void _onAnswered(bool isCorrect) {
    setState(() {
      answered = true;
      lastCorrect = isCorrect;
      if (isCorrect) correct++;
    });
  }

  void _next() {
    if (idx < widget.questions.length - 1) {
      setState(() {
        idx++;
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
        title: const Text("結果"),
        content: Text("正解: $correct / ${widget.questions.length}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("閉じる"),
          ),
          FilledButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text("ホームへ"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[idx];
    final progress = (idx + 1) / widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("問題 ${idx + 1} / ${widget.questions.length}"),
      ),
      body: LayoutBuilder(
        builder: (_, c) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    lastCorrect && answered ? "⭕ 正解！" : (!lastCorrect && answered ? "❌ 不正解…" : ""),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: answered ? (lastCorrect ? Colors.green : Colors.red) : Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: QuestionCard(
                      key: ValueKey(q.id), // ← これで状態持越しを防ぐ
                      q: q,
                      onAnswered: _onAnswered,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: answered ? _next : null,
                    child: Text(idx == widget.questions.length - 1 ? "結果を見る" : "次の問題へ"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
