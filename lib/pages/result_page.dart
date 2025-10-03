import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : score / total;
    return Scaffold(
      appBar: AppBar(title: const Text('結果')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('正解数: $score / $total', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              LinearProgressIndicator(value: ratio),
              const Spacer(),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('もう一度'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                    child: const Text('ホームへ'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
