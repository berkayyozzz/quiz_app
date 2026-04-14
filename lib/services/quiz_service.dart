import 'dart:math';
import '../models/question.dart';
import '../data/tyt_questions.dart';
import '../data/ayt_questions.dart';

class QuizService {
  static final Random _random = Random();

  static List<String> getSubjects(String examType) {
    List<Question> pool =
        examType == 'TYT' ? tytQuestions : aytQuestions;
    final subjects = pool.map((q) => q.subject).toSet().toList()..sort();
    return ['Karışık', ...subjects];
  }

  static List<Question> getQuestions({
    required String examType,
    required String subject,
    int count = 15,
    List<int> excludeIds = const [],
  }) {
    List<Question> pool =
        examType == 'TYT' ? tytQuestions : aytQuestions;

    if (subject != 'Karışık') {
      pool = pool.where((q) => q.subject == subject).toList();
    }

    if (excludeIds.isNotEmpty) {
      final unseen = pool.where((q) => !excludeIds.contains(q.id)).toList();
      if (unseen.length >= count) {
        pool = unseen;
      } else {
        final seen = pool.where((q) => excludeIds.contains(q.id)).toList();
        seen.shuffle(_random);
        final needed = count - unseen.length;
        pool = [
          ...unseen,
          ...seen.take(needed),
        ];
      }
    }

    pool = List.from(pool)..shuffle(_random);
    return pool.take(count).toList();
  }

  static QuizResult calculateResult({
    required List<Question> questions,
    required List<int?> answers,
    required String examType,
    required String subject,
  }) {
    int correct = 0;
    int wrong = 0;
    int blank = 0;

    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == null) {
        blank++;
      } else if (answers[i] == questions[i].correctIndex) {
        correct++;
      } else {
        wrong++;
      }
    }

    // Net hesabı: doğru - yanlış/4
    double netScore = correct - (wrong / 4);
    if (netScore < 0) netScore = 0;

    return QuizResult(
      totalQuestions: questions.length,
      correct: correct,
      wrong: wrong,
      blank: blank,
      netScore: netScore,
      examType: examType,
      subject: subject,
    );
  }
}
