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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'examType': examType,
      'subject': subject,
      'questionText': questionText,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      examType: map['examType'] as String,
      subject: map['subject'] as String,
      questionText: map['questionText'] as String,
      options: List<String>.from(map['options'] as List),
      correctIndex: map['correctIndex'] as int,
    );
  }
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
