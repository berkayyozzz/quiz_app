import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/ad_service.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _scoreSaved = false;

  @override
  void initState() {
    super.initState();
    
    // Show AdMob Interstitial Ad
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdService().showInterstitialAd();
      _saveScore();
    });
  }


  Future<void> _saveScore() async {
    final quiz = Provider.of<QuizProvider>(context, listen: false);
    final result = quiz.result;
    if (result == null) return;

    final authService = AuthService();
    final user = authService.currentUser;
    if (user != null) {
      final firestoreService = FirestoreService();
      await firestoreService.saveQuizResult(
        user.uid,
        user.displayName ?? 'Misafir',
        result.netScore,
      );
      if (mounted) {
        setState(() {
          _scoreSaved = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D1A), Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: Consumer<QuizProvider>(
            builder: (context, quiz, _) {
              final result = quiz.result;
              if (result == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final isTYT = result.examType == 'TYT';
              final primaryColor = isTYT
                  ? const Color(0xFF6C63FF)
                  : const Color(0xFFFF6B35);
              final percentage = result.percentage;

              String emoji;
              String message;
              if (percentage >= 80) {
                emoji = '🏆';
                message = 'Mükemmel! Harika bir performans!';
              } else if (percentage >= 60) {
                emoji = '👏';
                message = 'Harika! Çok iyi gidiyorsun!';
              } else if (percentage >= 40) {
                emoji = '💪';
                message = 'İyi! Biraz daha çalışmaya devam!';
              } else {
                emoji = '📚';
                message = 'Daha fazla çalışma vakti!';
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(emoji, style: const TextStyle(fontSize: 64))
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.elasticOut),
                    const SizedBox(height: 16),
                    Text(
                      quiz.isDenemeMode ? 'Deneme Sınavı Sonucu' : 'Sonuçların',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 40),

                    CircularPercentIndicator(
                      radius: 90,
                      lineWidth: 12,
                      percent: (percentage / 100).clamp(0.0, 1.0),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${percentage.toStringAsFixed(0)}%',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Başarı',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white38,
                            ),
                          ),
                        ],
                      ),
                      progressColor: primaryColor,
                      backgroundColor: Colors.white12,
                      animation: true,
                      animationDuration: 1200,
                      circularStrokeCap: CircularStrokeCap.round,
                    ).animate().fadeIn(delay: 400.ms),

                    const SizedBox(height: 36),

                    Row(
                      children: [
                        _buildStatCard(
                            '✅ Doğru', result.correct.toString(), Colors.greenAccent, 0),
                        const SizedBox(width: 12),
                        _buildStatCard(
                            '❌ Yanlış', result.wrong.toString(), Colors.redAccent, 100),
                        const SizedBox(width: 12),
                        _buildStatCard(
                            '➖ Boş', result.blank.toString(), Colors.white38, 200),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Net score
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.3),
                            primaryColor.withOpacity(0.1)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryColor.withOpacity(0.4)),
                      ),
                      child: Column(
                        children: [
                          Text('Net Puan',
                              style: GoogleFonts.poppins(
                                  color: Colors.white54, fontSize: 14)),
                          const SizedBox(height: 8),
                          Text(
                            result.netScore.toStringAsFixed(2),
                            style: GoogleFonts.poppins(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            '${result.examType} • ${result.subject}',
                            style: GoogleFonts.poppins(
                                color: Colors.white38, fontSize: 12),
                          ),
                          if (_scoreSaved) ...[
                            const SizedBox(height: 16),
                            const Divider(color: Colors.white10),
                            const SizedBox(height: 8),
                            StreamBuilder<UserProfile?>(
                              stream: FirestoreService().getUserProfile(AuthService().currentUser!.uid),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return const SizedBox();
                                final streak = snapshot.data!.currentStreak;
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('🔥', style: TextStyle(fontSize: 24)),
                                        const SizedBox(width: 8),
                                        Text(
                                          '$streak Günlük Seri!',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Harika gidiyorsun, yarın da bekleriz!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn().scale(curve: Curves.elasticOut, duration: 800.ms);
                              },
                            ),
                          ],
                        ],
                      ),
                    ).animate().slideY(begin: 0.2, delay: 600.ms).fadeIn(),


                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [primaryColor, primaryColor.withOpacity(0.7)]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            quiz.startQuiz(isDeneme: quiz.isDenemeMode);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const QuizScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            '🔄 Tekrar Dene',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 800.ms),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          quiz.resetQuiz();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                            (_) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(
                          '🏠 Ana Sayfa',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white70),
                        ),
                      ),
                    ).animate().fadeIn(delay: 900.ms),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, Color color, int delayMs) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.white54),
            ),
          ],
        ),
      ).animate().scale(delay: (500 + delayMs).ms, curve: Curves.elasticOut),
    );
  }
}
