import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/ad_manager.dart';
import '../services/analytics_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    AdManager.loadInterstitialAd();
    
    // Analytics: Quiz başlangıcını logla
    final quiz = context.read<QuizProvider>();
    AnalyticsService().logQuizStarted(quiz.examType);
    
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final quiz = context.read<QuizProvider>();
      quiz.tickTimer();
      if (quiz.quizFinished) {
        _timer?.cancel();
        AdManager.showInterstitialAd(
          onAdDismissed: () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ResultScreen()),
              );
            }
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleAnswer(int index, QuizProvider quiz) {
    if (quiz.currentAnswer != null) return;
    quiz.selectAnswer(index);
  }

  void _handleNext(QuizProvider quiz) {
    if (quiz.isDenemeMode) {
      if (quiz.currentIndex == quiz.questions.length - 1) {
        _timer?.cancel();
        quiz.finishQuiz();
        AdManager.showInterstitialAd(
          onAdDismissed: () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ResultScreen()),
              );
            }
          },
        );
      } else if ((quiz.currentIndex + 1) % 20 == 0) {
        // Her 20 soruda bir reklam göster (Deneme Modunda)
        AdManager.showInterstitialAd(
          onAdDismissed: () {
            if (mounted) {
              quiz.nextQuestion();
            }
          },
        );
      } else {
        quiz.nextQuestion();
      }
    } else {
      _timer?.cancel();
      if (quiz.currentIndex == quiz.questions.length - 1) {
        quiz.finishQuiz();
        AdManager.showInterstitialAd(
          onAdDismissed: () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ResultScreen()),
              );
            }
          },
        );
      } else {
        quiz.nextQuestion();
        _startTimer();
      }
    }
  }

  void _showQuestionNavigator(QuizProvider quiz) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _SoruNavigatorSheet(quiz: quiz),
    );
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
              if (quiz.currentQuestion == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final q = quiz.currentQuestion!;
              final isTYT = quiz.examType == 'TYT';
              final primaryColor = isTYT
                  ? const Color(0xFF6C63FF)
                  : const Color(0xFFFF6B35);

              return Column(
                children: [
                  _buildTopBar(quiz, primaryColor),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            _buildSubjectBadge(q.subject, primaryColor),
                            const SizedBox(height: 20),
                            _buildQuestionCard(q.questionText),
                            const SizedBox(height: 24),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: q.options.length,
                              itemBuilder: (_, i) => _buildOptionTile(
                                  context, i, q.options[i], quiz, primaryColor),
                            ),
                            _buildNavigationRow(quiz, primaryColor),
                            _buildBottomBar(quiz, primaryColor),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRow(QuizProvider quiz, Color primaryColor) {
    if (!quiz.isDenemeMode) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: quiz.currentIndex > 0 ? () => quiz.previousQuestion() : null,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: Text('Geri', style: GoogleFonts.poppins(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white12,
              foregroundColor: Colors.white70,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _showQuestionNavigator(quiz),
            icon: const Icon(Icons.grid_view_rounded, size: 18),
            label: Text('Soru Listesi', style: GoogleFonts.poppins(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor.withOpacity(0.2),
              foregroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(QuizProvider quiz, Color primaryColor) {
    if (quiz.isDenemeMode) {
      return _buildDenemeTopBar(quiz, primaryColor);
    }

    final timeRatio = quiz.secondsLeft / 90;
    final timerColor = quiz.secondsLeft > 30
        ? primaryColor
        : quiz.secondsLeft > 10
            ? Colors.orange
            : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  _timer?.cancel();
                  context.read<QuizProvider>().resetQuiz();
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: LinearPercentIndicator(
                  percent: quiz.progress.clamp(0.0, 1.0),
                  lineHeight: 8,
                  backgroundColor: Colors.white12,
                  progressColor: primaryColor,
                  barRadius: const Radius.circular(10),
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  '${quiz.currentIndex + 1}/${quiz.questions.length}',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircularPercentIndicator(
                radius: 24,
                lineWidth: 3.5,
                percent: timeRatio.clamp(0.0, 1.0),
                center: Text(
                  '${quiz.secondsLeft}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: timerColor,
                  ),
                ),
                progressColor: timerColor,
                backgroundColor: Colors.white12,
                animation: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDenemeTopBar(QuizProvider quiz, Color primaryColor) {
    String formatTime(int totalSeconds) {
      int h = totalSeconds ~/ 3600;
      int m = (totalSeconds % 3600) ~/ 60;
      int s = totalSeconds % 60;
      return "${h > 0 ? '$h:' : ''}${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
    }

    final totalDuration = quiz.examType == 'TYT' ? 165 * 60 : 180 * 60;
    final timeRatio = quiz.totalSecondsLeft / totalDuration;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  _showExitDialog(context, quiz);
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${quiz.examType} Tam Deneme',
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    LinearPercentIndicator(
                      percent: quiz.progress.clamp(0.0, 1.0),
                      lineHeight: 8,
                      backgroundColor: Colors.white12,
                      progressColor: primaryColor,
                      barRadius: const Radius.circular(10),
                      animateFromLastPercent: true,
                      animationDuration: 300,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_rounded, color: Colors.redAccent, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          formatTime(quiz.totalSecondsLeft),
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${quiz.currentIndex + 1} / ${quiz.questions.length}',
                    style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context, QuizProvider quiz) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text('Sınavdan Çık?', style: GoogleFonts.poppins(color: Colors.white)),
        content: Text('Sınavı sonlandırmak istediğinize emin misiniz? Mevcut ilerlemeniz silinecektir.',
            style: GoogleFonts.poppins(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Devam Et', style: GoogleFonts.poppins(color: Colors.white54))),
          ElevatedButton(
            onPressed: () {
              _timer?.cancel();
              quiz.resetQuiz();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text('Çıkış Yap', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectBadge(String subject, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        subject,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildOptionTile(
    BuildContext context,
    int index,
    String option,
    QuizProvider quiz,
    Color primaryColor,
  ) {
    final answered = quiz.currentAnswer != null;
    final isCorrect = index == quiz.currentQuestion!.correctIndex;
    final isSelected = quiz.currentAnswer == index;

    Color borderColor = Colors.white12;
    Color bgColor = const Color(0xFF1E1E3F);
    Color textColor = Colors.white70;
    IconData? trailingIcon;

    if (answered) {
      if (isCorrect) {
        borderColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.greenAccent;
        trailingIcon = Icons.check_circle;
      } else if (isSelected && !isCorrect) {
        borderColor = Colors.redAccent;
        bgColor = Colors.red.withOpacity(0.15);
        textColor = Colors.redAccent;
        trailingIcon = Icons.cancel;
      }
    }

    final labels = ['A', 'B', 'C', 'D'];

    return GestureDetector(
      onTap: () => _handleAnswer(index, quiz),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: answered && isCorrect
                    ? Colors.green
                    : answered && isSelected
                        ? Colors.redAccent
                        : primaryColor.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: answered && (isCorrect || isSelected)
                        ? Colors.white
                        : primaryColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon,
                  color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                  size: 20),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 80).ms).slideX(begin: 0.1);
  }

  Widget _buildBottomBar(QuizProvider quiz, Color primaryColor) {
    final isLast = quiz.currentIndex == quiz.questions.length - 1;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: quiz.currentAnswer != null
                  ? [primaryColor, primaryColor.withOpacity(0.7)]
                  : [Colors.white12, Colors.white12],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton(
            onPressed:
                quiz.currentAnswer != null ? () => _handleNext(quiz) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              isLast ? 'Sonuçlara Git →' : 'Sonraki Soru →',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: quiz.currentAnswer != null
                    ? Colors.white
                    : Colors.white30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SoruNavigatorSheet extends StatelessWidget {
  final QuizProvider quiz;
  const _SoruNavigatorSheet({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Soru Listesi',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white54)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: quiz.questions.length,
              itemBuilder: (_, i) {
                final isCurrent = quiz.currentIndex == i;
                final isAnswered = quiz.answers[i] != null;
                return GestureDetector(
                  onTap: () {
                    quiz.jumpToQuestion(i);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? (quiz.examType == 'TYT' ? const Color(0xFF6C63FF) : const Color(0xFFFF6B35))
                          : isAnswered
                              ? Colors.green.withOpacity(0.2)
                              : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrent
                            ? Colors.white
                            : isAnswered
                                ? Colors.green.withOpacity(0.5)
                                : Colors.white12,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: GoogleFonts.poppins(
                          color: isCurrent || isAnswered ? Colors.white : Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              quiz.finishQuiz();
              AdManager.showInterstitialAd(
                onAdDismissed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('Sınavı Bitir', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
