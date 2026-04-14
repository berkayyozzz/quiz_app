import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Yanlış yapılan soruları sakla (resetQuiz sonrasında da kalır)
  List<Question> _lastWrongQuestions = [];

  // New for Deneme Modu
  bool _isDenemeMode = false;
  int _totalSecondsLeft = 0;

  // Timer
  int _secondsLeft = 90;

  static const String _wrongQuestionsKey = 'last_wrong_questions';

  // New for Deneme Modu seen questions
  Map<String, List<int>> _seenQuestions = {'TYT': [], 'AYT': []};
  static const String _seenQuestionsKey = 'seen_deneme_questions';

  QuizProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadWrongQuestions();
    await _loadSeenQuestions();
  }

  Future<void> _loadSeenQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? seenJson = prefs.getString(_seenQuestionsKey);
      if (seenJson != null) {
        final Map<String, dynamic> decoded = jsonDecode(seenJson);
        _seenQuestions = {
          'TYT': List<int>.from(decoded['TYT'] ?? []),
          'AYT': List<int>.from(decoded['AYT'] ?? []),
        };
      }
    } catch (e) {
      debugPrint('Çıkmış sorular yüklenirken hata: $e');
    }
  }

  Future<void> _saveSeenQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_seenQuestionsKey, jsonEncode(_seenQuestions));
    } catch (e) {
      debugPrint('Çıkmış sorular kaydedilirken hata: $e');
    }
  }

  void _addSeenQuestions(String examType, List<int> ids) {
    if (_seenQuestions[examType] == null) {
      _seenQuestions[examType] = [];
    }
    bool changed = false;
    for (int id in ids) {
      if (!_seenQuestions[examType]!.contains(id)) {
        _seenQuestions[examType]!.add(id);
        changed = true;
      }
    }
    if (changed) {
      _saveSeenQuestions();
    }
  }

  Future<void> _loadWrongQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? wrongJson = prefs.getString(_wrongQuestionsKey);
      if (wrongJson != null) {
        final List<dynamic> decoded = jsonDecode(wrongJson);
        _lastWrongQuestions = decoded
            .map((item) => Question.fromMap(item as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Yanlış sorular yüklenirken hata: $e');
    }
  }

  Future<void> _saveWrongQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String wrongJson = jsonEncode(
        _lastWrongQuestions.map((q) => q.toMap()).toList(),
      );
      await prefs.setString(_wrongQuestionsKey, wrongJson);
    } catch (e) {
      debugPrint('Yanlış sorular kaydedilirken hata: $e');
    }
  }

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
  List<Question> get lastWrongQuestions => _lastWrongQuestions;
  bool get hasWrongQuestions => _lastWrongQuestions.isNotEmpty;

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
      excludeIds: _isDenemeMode ? _seenQuestions[_examType] ?? [] : [],
    );

    if (_isDenemeMode) {
      _addSeenQuestions(_examType, _questions.map((q) => q.id).toList());
    }

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
    // Yanlış yapılan soruları kaydet
    _lastWrongQuestions = [];
    for (int i = 0; i < _questions.length; i++) {
      if (_answers[i] != null && _answers[i] != _questions[i].correctIndex) {
        _lastWrongQuestions.add(_questions[i]);
      }
    }

    _saveWrongQuestions(); // Kalıcı olarak kaydet

    _result = QuizService.calculateResult(
      questions: _questions,
      answers: _answers,
      examType: _examType,
      subject: _subject,
    );
    _quizFinished = true;
    notifyListeners();
  }

  /// Yanlış yapılan soruları tekrar çözmek için quiz başlat
  void startRetryWrongQuestions() {
    _isDenemeMode = false;
    _questions = List.from(_lastWrongQuestions);
    _answers = List.filled(_questions.length, null);
    _currentIndex = 0;
    _quizStarted = true;
    _quizFinished = false;
    _result = null;
    _secondsLeft = 90;
    _lastWrongQuestions = []; // Kullanıldı, temizle
    _saveWrongQuestions(); // Kaydı da temizle
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
