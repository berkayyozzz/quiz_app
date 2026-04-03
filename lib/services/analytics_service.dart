import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  // Kullanıcı giriş yaptığında
  Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  // Quiz başladığında
  Future<void> logQuizStarted(String category) async {
    await _analytics.logEvent(
      name: 'quiz_started',
      parameters: {
        'category': category,
      },
    );
  }

  // Quiz tamamlandığında
  Future<void> logQuizCompleted(String category, int score, int totalQuestions) async {
    await _analytics.logEvent(
      name: 'quiz_completed',
      parameters: {
        'category': category,
        'score': score,
        'total_questions': totalQuestions,
        'success_rate': (score / totalQuestions) * 100,
      },
    );
  }

  // Reklam izlendiğinde (Opsiyonel ama yararlı)
  Future<void> logAdImpression(String adType) async {
    await _analytics.logEvent(
      name: 'ad_impression_custom',
      parameters: {
        'ad_type': adType,
      },
    );
  }

  // Özel ekran görüntüleme (Eğer otomatik takip yetmezse)
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }
}
