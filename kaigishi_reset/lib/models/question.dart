// lib/models/question.dart
class Question {
  final String id;
  final int grade;
  final String topicId;
  final String question;
  final List<String> choices;
  final int answerIndex;
  final String explanation;

  const Question({
    required this.id,
    required this.grade,
    required this.topicId,
    required this.question,
    required this.choices,
    required this.answerIndex,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> j) => Question(
        id: j['id'] ?? '',
        grade: (j['grade'] is String)
            ? int.tryParse(j['grade']) ?? 0
            : (j['grade'] ?? 0),
        topicId: (j['topic_id'] ?? j['topicId'] ?? '') as String,
        question: (j['question'] ?? '') as String,
        choices: (j['choices'] as List? ?? const [])
            .map((e) => e.toString())
            .toList(),
        answerIndex: (j['answer_index'] ?? j['answerIndex'] ?? 0) as int,
        explanation: (j['explanation'] ?? '') as String,
      );
}
