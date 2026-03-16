import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../services/quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  // Quiz setup
  String _examType = 'TYT';
  String _subject = 'Karışık';

  // Quiz state
  List<Question> _questions = [];
  List<int?> _answers = [];
  int _currentIndex = 0;
  bool _quizStarted = false;
  bool _quizFinished = false;
  QuizResult? _result;

  // New for Deneme Modu
  bool _isDenemeMode = false;
  int _totalSecondsLeft = 0;

  // Timer
  int _secondsLeft = 90;

  // Getters
  String get examType => _examType;
  String get subject => _subject;
  List<Question> get questions => _questions;
  List<int?> get answers => _answers;
  int get currentIndex => _currentIndex;
  bool get quizStarted => _quizStarted;
  bool get quizFinished => _quizFinished;
  QuizResult? get result => _result;
  int get secondsLeft => _secondsLeft;
  bool get isDenemeMode => _isDenemeMode;
  int get totalSecondsLeft => _totalSecondsLeft;

  Question? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentIndex] : null;

  int? get currentAnswer =>
      _answers.isNotEmpty ? _answers[_currentIndex] : null;

  double get progress =>
      _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;

  List<String> getSubjects() => QuizService.getSubjects(_examType);

  void setExamType(String type) {
    _examType = type;
    _subject = 'Karışık';
    notifyListeners();
  }

  void setSubject(String subject) {
    _subject = subject;
    notifyListeners();
  }

  void startQuiz({bool isDeneme = false}) {
    _isDenemeMode = isDeneme;
    
    int count = isDeneme ? (_examType == 'TYT' ? 120 : 80) : 15;
    
    _questions = QuizService.getQuestions(
      examType: _examType,
      subject: _isDenemeMode ? 'Karışık' : _subject,
      count: count,
    );
    _answers = List.filled(_questions.length, null);
    _currentIndex = 0;
    _quizStarted = true;
    _quizFinished = false;
    _result = null;
    
    if (_isDenemeMode) {
      _totalSecondsLeft = _examType == 'TYT' ? 165 * 60 : 180 * 60;
    } else {
      _secondsLeft = 90;
    }
    
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (_quizFinished) return;
    _answers[_currentIndex] = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      if (!_isDenemeMode) {
        _secondsLeft = 90;
      }
      notifyListeners();
    } else if (!_isDenemeMode) {
      finishQuiz();
    }
  }

  void jumpToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void finishQuiz() {
    _result = QuizService.calculateResult(
      questions: _questions,
      answers: _answers,
      examType: _examType,
      subject: _subject,
    );
    _quizFinished = true;
    notifyListeners();
  }

  void resetQuiz() {
    _quizStarted = false;
    _quizFinished = false;
    _questions = [];
    _answers = [];
    _currentIndex = 0;
    _result = null;
    _secondsLeft = 90;
    _isDenemeMode = false;
    _totalSecondsLeft = 0;
    notifyListeners();
  }

  void tickTimer() {
    if (_isDenemeMode) {
      if (_totalSecondsLeft > 0) {
        _totalSecondsLeft--;
        notifyListeners();
        if (_totalSecondsLeft == 0) {
          finishQuiz();
        }
      }
    } else {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        notifyListeners();
        if (_secondsLeft == 0) {
          nextQuestion();
        }
      }
    }
  }
}
