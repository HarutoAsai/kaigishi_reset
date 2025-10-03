import 'package:flutter_test/flutter_test.dart';
import 'package:kaigishi_reset/main.dart';

void main() {
  testWidgets('App loads and shows home screen', (WidgetTester tester) async {
    // アプリを起動
    await tester.pumpWidget(const App());

    // ホーム画面のタイトルが表示されているかを確認
    expect(find.text('海技士 試験トレーナー'), findsOneWidget);

    // 「今日の5問」ボタンがあるか確認
    expect(find.text('今日の5問'), findsOneWidget);

    // 「級とトピックで選ぶ」ボタンがあるか確認
    expect(find.text('級とトピックで選ぶ'), findsOneWidget);
  });
}
