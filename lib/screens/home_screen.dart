import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/ad_manager.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/haptic_helper.dart';
import '../services/notification_service.dart';
import '../services/premium_service.dart';
import 'dart:async';
import 'dart:io';
import 'quiz_screen.dart';
import 'duel_screen.dart';
import 'leaderboard_screen.dart';
import 'premium_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRetryAdLoading = false;
  StreamSubscription? _inviteSubscription;
  final Set<String> _handledInvites = {};

  @override
  void initState() {
    super.initState();
    // Ask for notification permissions right away
    NotificationService().requestPermissions();
    // Ödül reklamını önceden yükle
    AdManager.loadRewardedAd();
    _listenForInvites();
    HapticHelper.init();
  }

  void _listenForInvites() {
    final uid = AuthService().currentUser?.uid;
    if (uid == null) return;
    
    _inviteSubscription = FirestoreService().listenToIncomingInvites(uid).listen((snapshot) {
      if (!mounted) return;
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final doc = change.doc;
          final data = doc.data() as Map<String, dynamic>;
          final inviteId = doc.id;
          
          if (!_handledInvites.contains(inviteId) && data['status'] == 'pending') {
             _handledInvites.add(inviteId);
             _showInviteDialog(inviteId, data['fromName'], data['roomCode']);
          }
        }
      }
    });
  }

  void _showInviteDialog(String inviteId, String fromName, String roomCode) {
    showDialog(
       context: context,
       barrierDismissible: false,
       builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E3F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('⚔️ Düello İsteği!', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text('$fromName sana meydan okuyor!\nKabul ediyor musun?', style: GoogleFonts.poppins(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () {
                 FirestoreService().updateInviteStatus(inviteId, 'rejected');
                 Navigator.pop(ctx);
              },
              child: Text('Reddet', style: GoogleFonts.poppins(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                 FirestoreService().updateInviteStatus(inviteId, 'accepted');
                 Navigator.pop(ctx);
                 Navigator.push(context, MaterialPageRoute(builder: (_) => DuelScreen(initialJoinCode: roomCode)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4757),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Kabul Et', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ]
       )
    );
  }

  @override
  void dispose() {
    _inviteSubscription?.cancel();
    super.dispose();
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
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildDuelCard(context),
                    const SizedBox(height: 32),
                    _buildExamSelector(quiz),
                    const SizedBox(height: 32),
                    Text(
                      'Konu Seç',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSubjectChips(quiz),
                    const SizedBox(height: 32),
                    _buildDenemeSection(context, quiz),
                    if (quiz.hasWrongQuestions) ...[
                      const SizedBox(height: 32),
                      _buildRetryWrongCard(context, quiz),
                    ],
                    const SizedBox(height: 32),
                    _buildStartButton(context, quiz),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz Zamanı! 🎯',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
              const SizedBox(height: 8),
              Text(
                'TYT ve AYT sorularıyla kendini sına',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white54,
                ),
              ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Premium butonu
            if (!Platform.isIOS)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PremiumScreen()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: PremiumService().isPremium
                        ? const LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                          )
                        : null,
                    color: PremiumService().isPremium
                        ? null
                        : const Color(0xFFFFD700).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        PremiumService().isPremium ? '👑' : '💎',
                        style: const TextStyle(fontSize: 14),
                      ),
                      if (!PremiumService().isPremium) ...[
                        const SizedBox(width: 4),
                        Text(
                          'PRO',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFD700),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ).animate().fadeIn(),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(AuthService().currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                int streak = 0;
                if (snapshot.hasData && snapshot.data!.exists) {
                   final data = snapshot.data!.data() as Map<String, dynamic>?;
                   streak = data?['currentStreak'] ?? 0;
                }
                if (streak > 0) {
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '$streak',
                          style: GoogleFonts.poppins(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn();
                }
                return const SizedBox.shrink();
              },
            ),
            IconButton(
              icon: const Icon(Icons.leaderboard, color: Colors.amberAccent, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                );
              },
            ),

            PopupMenuButton<String>(
              icon: const Icon(Icons.settings, color: Colors.white54),
              color: const Color(0xFF1E1E3F),
              onSelected: (value) async {
                if (value == 'logout') {
                  await AuthService().signOut();
                } else if (value == 'delete') {
                  _showDeleteAccountDialog(context);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Çıkış Yap', style: GoogleFonts.poppins(color: Colors.white)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete_forever, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      Text('Hesabı Sil', style: GoogleFonts.poppins(color: Colors.redAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExamSelector(QuizProvider quiz) {
    final exams = [
      {
        'type': 'TYT',
        'title': 'TYT',
        'subtitle': 'Temel Yetenek Testi',
        'icon': '📘',
        'gradient': [const Color(0xFF6C63FF), const Color(0xFF3D5AF1)],
      },
      {
        'type': 'AYT',
        'title': 'AYT',
        'subtitle': 'Alan Yeterlilik Testi',
        'icon': '📙',
        'gradient': [const Color(0xFFFF6B35), const Color(0xFFFF8C42)],
      },
    ];

    return Row(
      children: exams.asMap().entries.map((entry) {
        final e = entry.value;
        final isSelected = quiz.examType == e['type'];
        return Expanded(
          child: GestureDetector(
            onTap: () => quiz.setExamType(e['type'] as String),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                right: entry.key == 0 ? 12 : 0,
                left: entry.key == 1 ? 12 : 0,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: e['gradient'] as List<Color>,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : const Color(0xFF1E1E3F),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white12,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (e['gradient'] as List<Color>)[0].withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e['icon'] as String, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 12),
                  Text(
                    e['title'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    e['subtitle'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isSelected ? Colors.white70 : Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: (entry.key * 100).ms).scale(begin: const Offset(0.9, 0.9)),
        );
      }).toList(),
    );
  }

  Widget _buildSubjectChips(QuizProvider quiz) {
    final subjects = quiz.getSubjects();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: subjects.asMap().entries.map((entry) {
        final subject = entry.value;
        final isSelected = quiz.subject == subject;
        final isTYT = quiz.examType == 'TYT';
        return GestureDetector(
          onTap: () => quiz.setSubject(subject),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: isTYT
                          ? [const Color(0xFF6C63FF), const Color(0xFF3D5AF1)]
                          : [const Color(0xFFFF6B35), const Color(0xFFFF8C42)],
                    )
                  : null,
              color: isSelected ? null : const Color(0xFF1E1E3F),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.white12,
              ),
            ),
            child: Text(
              subject,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.white54,
              ),
            ),
          ),
        ).animate().fadeIn(delay: (entry.key * 50).ms);
      }).toList(),
    );
  }

  Widget _buildStartButton(BuildContext context, QuizProvider quiz) {
    final isTYT = quiz.examType == 'TYT';
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isTYT
                ? [const Color(0xFF6C63FF), const Color(0xFF3D5AF1)]
                : [const Color(0xFFFF6B35), const Color(0xFFFF8C42)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (isTYT ? const Color(0xFF6C63FF) : const Color(0xFFFF6B35)).withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            quiz.startQuiz();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.play_arrow_rounded, size: 26, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Quizi Başlat  •  15 Soru',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: 0.3, duration: 600.ms).fadeIn();
  }

  Widget _buildDenemeSection(BuildContext context, QuizProvider quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YKS Deneme Modu',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildDenemeCard(
              context,
              quiz,
              'TYT',
              '120 Soru / 165 Dk',
              const Color(0xFF6C63FF),
              Icons.timer_outlined,
            ),
            const SizedBox(width: 12),
            _buildDenemeCard(
              context,
              quiz,
              'AYT',
              '80 Soru / 180 Dk',
              const Color(0xFFFF6B35),
              Icons.history_edu_outlined,
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildDenemeCard(
    BuildContext context,
    QuizProvider quiz,
    String type,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          quiz.setExamType(type);
          quiz.startQuiz(isDeneme: true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 12),
              Text(
                '$type Tam Deneme',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuelCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF4757).withOpacity(0.18),
            const Color(0xFFFF6B81).withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF4757).withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4757).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DuelScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF4757).withOpacity(0.4),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('⚔️', style: TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1v1 Düello Modu',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rakibinle yarış • 10 Soru',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF4757).withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    'Oyna',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1);
  }

  Widget _buildRetryWrongCard(BuildContext context, QuizProvider quiz) {
    final wrongCount = quiz.lastWrongQuestions.length;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF6B35).withOpacity(0.15),
            const Color(0xFFFF8C42).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _isRetryAdLoading
              ? null
              : () => _handleRetryWrongQuestions(context, quiz),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _isRetryAdLoading
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text('🔄', style: TextStyle(fontSize: 24)),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yanlışları Tekrar Çöz',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$wrongCount yanlış soru${PremiumService().isPremium ? '' : ' • Reklam izle ve çöz'}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFF6B35).withOpacity(0.5),
                    ),
                  ),
                  child: PremiumService().isPremium
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('✨', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              'Çöz',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFD700),
                              ),
                            ),
                          ],
                        )
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🎬', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      Text(
                        'İzle',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF8C42),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.15);
  }

  void _handleRetryWrongQuestions(BuildContext context, QuizProvider quiz) {
    // Premium kullanıcılar direkt çözer
    if (PremiumService().isPremium) {
      quiz.startRetryWrongQuestions();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const QuizScreen()),
      );
      return;
    }

    setState(() {
      _isRetryAdLoading = true;
    });

    // Reklam yüklenmediyse kısa bir süre bekle
    Future<void> showAd() async {
      if (!AdManager.isRewardedAdLoaded) {
        await Future.delayed(const Duration(seconds: 2));
      }

      AdManager.showRewardedAd(
        onRewarded: () {
          if (mounted) {
            setState(() {
              _isRetryAdLoading = false;
            });
            quiz.startRetryWrongQuestions();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            );
          }
        },
        onAdFailed: () {
          if (mounted) {
            setState(() {
              _isRetryAdLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reklam yüklenemedi. Lütfen tekrar deneyin.'),
                backgroundColor: Colors.orangeAccent,
              ),
            );
          }
        },
      );
    }

    showAd();
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController confirmController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E3F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Hesabı Sil', style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hesabınızı silmek istediğinize emin misiniz? Bu işlem geri alınamaz ve tüm verileriniz (skorlar, düello geçmişi, abonelik) kalıcı olarak silinir.',
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Text(
                  'Onaylamak için "SİL" yazın:',
                  style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: confirmController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(ctx),
                child: Text('İptal', style: GoogleFonts.poppins(color: Colors.white54)),
              ),
              ElevatedButton(
                onPressed: (confirmController.text.trim().toUpperCase() != 'SİL' || isLoading)
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        try {
                          await AuthService().deleteAccount();
                          if (ctx.mounted) {
                            Navigator.pop(ctx);
                          }
                        } catch (e) {
                          setState(() => isLoading = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Hesap silinemedi. Lütfen çıkış yapıp tekrar giriş yaptıktan sonra deneyin.'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  disabledBackgroundColor: Colors.redAccent.withOpacity(0.3),
                ),
                child: isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Kalıcı Olarak Sil', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
      ),
    );
  }
}
