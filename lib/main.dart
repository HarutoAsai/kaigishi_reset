import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'models/question.dart';
import 'pages/quiz_page.dart';

Future<List<Question>> loadQuestions() async {
  final text = await rootBundle.loadString('assets/questions/questions_v2.json');
  final data = json.decode(text) as List;
  return data.map((e) => Question.fromJson(Map<String, dynamic>.from(e))).toList();
}

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
      theme: base.copyWith(
        textTheme: GoogleFonts.notoSansJpTextTheme(base.textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: base.colorScheme.surface,
          foregroundColor: base.colorScheme.onSurface,
          elevation: 0,
          titleTextStyle: GoogleFonts.notoSansJp(
            fontSize: 20, fontWeight: FontWeight.w600, color: base.colorScheme.onSurface,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FB),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海技士 試験トレーナー')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity, height: 64,
                  child: FilledButton(
                    onPressed: () async {
                      try {
                        final questions = await loadQuestions();
                        if (context.mounted) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => QuizPage(questions: questions),
                          ));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('問題の読み込みに失敗: $e')),
                          );
                        }
                      }
                    },
                    child: const Text('問題を解く（JSONから読み込み）'),
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
