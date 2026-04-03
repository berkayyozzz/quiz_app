import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/ad_manager.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'home_screen.dart';
import 'leaderboard_screen.dart';
import 'quiz_screen.dart';
import '../services/analytics_service.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _scoreSaved = false;
  bool _isSaving = false;
  String? _saveError;
  bool _rewardClaimed = false;
  bool _isRewardLoading = false;
  int _rewardWatchCount = 0;
  bool _isCheckingLimit = true;
  int? _weeklyRank;

  @override
  void initState() {
    super.initState();
    // Ödül reklamını önceden yükle
    AdManager.loadRewardedAd();
    
    // Analytics: Quiz tamamlanmasını logla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quiz = Provider.of<QuizProvider>(context, listen: false);
      if (quiz.result != null) {
        AnalyticsService().logQuizCompleted(
          quiz.result!.subject,
          quiz.result!.correct,
          quiz.questions.length,
        );
      }
      
      _saveScore();
      _checkRewardLimit();
      _fetchWeeklyRank();
    });
  }

  Future<void> _checkRewardLimit() async {
    final authService = AuthService();
    final user = authService.currentUser;
    if (user != null) {
      try {
        final firestoreService = FirestoreService();
        final profile = await firestoreService.getUserProfile(user.uid);
        if (profile != null && mounted) {
          int count = profile.rewardedAdsWatchedToday;
          
          // Gün kontrolü yap (resetleme mantığı modelde olsa da UI'da da kontrol edelim)
          if (profile.lastRewardedAdDate != null) {
            DateTime now = DateTime.now();
            DateTime today = DateTime(now.year, now.month, now.day);
            DateTime lastAdDate = profile.lastRewardedAdDate!;
            DateTime lastAdDay = DateTime(lastAdDate.year, lastAdDate.month, lastAdDate.day);
            
            if (today.isAfter(lastAdDay)) {
              count = 0;
            }
          }

          setState(() {
            _rewardWatchCount = count;
            _isCheckingLimit = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isCheckingLimit = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isCheckingLimit = false;
        });
      }
    }
  }

  Future<void> _fetchWeeklyRank() async {
    final authService = AuthService();
    final user = authService.currentUser;
    if (user != null) {
      try {
        final firestoreService = FirestoreService();
        final rank = await firestoreService.getUserWeeklyRank(user.uid);
        if (mounted) {
          setState(() {
            _weeklyRank = rank;
          });
        }
      } catch (_) {}
    }
  }

  Future<void> _saveScore() async {
    if (_isSaving) return;

    final quiz = Provider.of<QuizProvider>(context, listen: false);
    final result = quiz.result;
    if (result == null) return;

    final authService = AuthService();
    final user = authService.currentUser;
    
    if (user != null) {
      setState(() {
        _isSaving = true;
        _saveError = null;
      });

      try {
        final firestoreService = FirestoreService();
        await firestoreService.saveQuizResult(
          user.uid,
          user.displayName ?? 'Misafir-${(user.uid.length >= 5) ? user.uid.substring(0, 5) : user.uid}',
          result.netScore,
        );
        if (mounted) {
          setState(() {
            _scoreSaved = true;
            _isSaving = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Skor başarıyla güncellendi! 🚀'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isSaving = false;
            _saveError = 'Skor kaydedilirken bir hata oluştu.';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: $e'),
              backgroundColor: Colors.redAccent,
              action: SnackBarAction(
                label: 'Tekrar Dene',
                textColor: Colors.white,
                onPressed: _saveScore,
              ),
            ),
          );
        }
      }
    } else {
      setState(() {
        _saveError = 'Giriş yapılmış kullanıcı bulunamadı.';
      });
    }
  }

  Future<void> _watchRewardedAd(double currentNetScore) async {
    setState(() {
      _isRewardLoading = true;
    });

    // Reklam yüklenmediyse kısa bir süre bekle
    if (!AdManager.isRewardedAdLoaded) {
      await Future.delayed(const Duration(seconds: 2));
    }

    AdManager.showRewardedAd(
      onRewarded: () async {
        // Ödül kazanıldı, +10 puan ekle
        final authService = AuthService();
        final user = authService.currentUser;

        if (user != null) {
          try {
            final firestoreService = FirestoreService();
            final success = await firestoreService.claimRewardedAdBonus(
              user.uid,
              user.displayName ?? 'Misafir',
            );

            if (mounted) {
              if (success) {
                setState(() {
                  _rewardClaimed = true;
                  _rewardWatchCount += 1;
                  _isRewardLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('+10 bonus puan eklendi! 🎉'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                setState(() {
                  _isRewardLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Günlük ödül limitine ulaştınız (Maks 3).'),
                    backgroundColor: Colors.orangeAccent,
                  ),
                );
              }
            }
          } catch (e) {
            if (mounted) {
              setState(() {
                _isRewardLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bonus puan kaydedilirken hata: $e'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          }
        } else {
          if (mounted) {
            setState(() {
              _isRewardLoading = false;
            });
          }
        }
      },
      onAdFailed: () {
        if (mounted) {
          setState(() {
            _isRewardLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reklam yüklenemedi. Lütfen daha sonra tekrar deneyin.'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      },
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
                            const SizedBox(height: 8),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_done, color: Colors.greenAccent, size: 16),
                                SizedBox(width: 4),
                                Text('Skor Kaydedildi', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ).animate().slideY(begin: 0.2, delay: 600.ms).fadeIn(),

                    if (_saveError != null) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: _isSaving ? null : _saveScore,
                          icon: _isSaving 
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
                              : const Icon(Icons.refresh, color: Colors.orangeAccent),
                          label: Text(
                            _isSaving ? 'Kaydediliyor...' : 'Puanı Tekrar Gönder',
                            style: GoogleFonts.poppins(color: Colors.orangeAccent),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],

                    // Haftalık Sıralama ve Liderlik Tablosu
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text('🏅', style: TextStyle(fontSize: 22)),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Haftalık Sıralama',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.white54,
                                      ),
                                    ),
                                    _weeklyRank != null
                                        ? RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '$_weeklyRank',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '. sıradasın',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            'Yükleniyor...',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white38,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                                );
                              },
                              icon: const Icon(Icons.leaderboard, size: 18),
                              label: Text(
                                'Liderlik Tablosunu Gör',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.withOpacity(0.2),
                                foregroundColor: Colors.amber,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.amber.withOpacity(0.4)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.15),

                    // Ödül Reklamı Butonu / Limit Bilgisi
                    if (!_rewardClaimed && !_isCheckingLimit) ...[
                      if (_rewardWatchCount < 3) ...[
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFD700),
                                const Color(0xFFFFA500),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _isRewardLoading
                                ? null
                                : () => _watchRewardedAd(result.netScore),
                            icon: _isRewardLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black87,
                                    ),
                                  )
                                : const Text('🎬', style: TextStyle(fontSize: 20)),
                            label: Text(
                              _isRewardLoading
                                  ? 'Reklam Yükleniyor...'
                                  : 'Reklam İzle  +10 Puan',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ).animate().fadeIn(delay: 700.ms).shimmer(
                              duration: 2000.ms,
                              color: Colors.white.withOpacity(0.3),
                            ),
                         Padding(
                           padding: const EdgeInsets.only(top: 8.0),
                           child: Text(
                             'Kalan günlük ödül hakkı: ${3 - _rewardWatchCount}',
                             style: GoogleFonts.poppins(color: Colors.white38, fontSize: 11),
                           ),
                         ),
                      ] else ...[
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.info_outline, color: Colors.orangeAccent, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Günde en fazla 3 kez ödül alabilirsiniz.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 700.ms),
                      ],
                    ],

                    if (_rewardClaimed) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '+10 Bonus Puan Eklendi! 🎉',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                      ).animate().scale(curve: Curves.elasticOut),
                    ],

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
