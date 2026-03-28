import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yks_akademi/main.dart';
import 'package:yks_akademi/providers/quiz_provider.dart';

void main() {
  testWidgets('QuizApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const QuizApp(),
      ),
    );
    expect(find.text('Quiz Zamanı! 🎯'), findsOneWidget);
  });
}
