import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "models/question.dart";
import "pages/quiz_page.dart";
import "theme/app_theme.dart";

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "海技士 試験トレーナー",
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      home: const HomePage(),
      locale: const Locale("ja"),
      supportedLocales: const [Locale("ja")],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sample = [
      Question(
        id: "1_nav_skill_0001",
        grade: 1,
        topicId: "nav_skill",
        question: "緯度1分は何海里？",
        choices: ["1海里","10海里","60海里","600海里"],
        answerIndex: 0,
        explanation: "緯度1分=1海里(約1852m)。",
      ),
      Question(
        id: "1_law_0001",
        grade: 1,
        topicId: "law",
        question: "信号旗“A”の意味は？",
        choices: ["危険物運搬中","私は潜水夫を下に入れている","港に入る","全速後進"],
        answerIndex: 1,
        explanation: "潜水夫あり。低速・十分な距離を取る。",
      ),
    ];

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("海技士 試験トレーナー")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sailing, size: 72, color: cs.primary),
                const SizedBox(height: 18),
                Text(
                  "学習を開始しましょう",
                  style: GoogleFonts.notoSansJp(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QuizPage(questions: sample)),
                      );
                    },
                    child: const Text("サンプル問題を解く"),
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
