class Question {
  final int id;
  final String examType; // 'TYT' or 'AYT'
  final String subject;
  final String questionText;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.id,
    required this.examType,
    required this.subject,
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });
}

enum ExamType { tyt, ayt }

class QuizResult {
  final int totalQuestions;
  final int correct;
  final int wrong;
  final int blank;
  final double netScore;
  final String examType;
  final String subject;

  QuizResult({
    required this.totalQuestions,
    required this.correct,
    required this.wrong,
    required this.blank,
    required this.netScore,
    required this.examType,
    required this.subject,
  });

  double get percentage => totalQuestions > 0 ? (correct / totalQuestions) * 100 : 0;
}
