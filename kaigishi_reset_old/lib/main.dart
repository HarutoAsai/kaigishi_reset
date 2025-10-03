// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/question.dart';
import 'pages/quiz_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '海技士 試験トレーナー',
      // 日本語ロケールを明示（フォント選択のヒントにもなる）
      locale: const Locale('ja'),
      supportedLocales: const [Locale('ja')],
      theme: base.copyWith(
        textTheme: GoogleFonts.notoSansJpTextTheme(base.textTheme),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.notoSansJp(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ 完全固定のサンプル問題（assets 読み込みなし）
    final sampleQuestions = [
      Question(
        id: "1_nav_skill_0001",
        grade: 1,
        topicId: "nav_skill",
        question: "緯度1分は何海里？",
        choices: ["1海里", "10海里", "60海里", "600海里"],
        answerIndex: 0,
        explanation: "緯度1分=1海里(約1852m)。",
      ),
      Question(
        id: "1_law_0001",
        grade: 1,
        topicId: "law",
        question: "信号旗“A”の意味は？",
        choices: ["危険物運搬中", "私は潜水夫を下に入れている", "港に入る", "全速後進"],
        answerIndex: 1,
        explanation: "潜水夫あり。低速・十分な距離を取る。",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('海技士 試験トレーナー[BUILD-1]')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint('[Home] ボタン押下 → QuizPageへ遷移');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizPage(questions: sampleQuestions),
              ),
            );
          },
          child: const Text("サンプル問題を解く[BUILD-1]"),
        ),
      ),
    );
  }
}

