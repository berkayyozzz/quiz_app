import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/auth_service.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final user = AuthService().currentUser;

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
              if (user != null)
                StreamBuilder<UserProfile?>(
                  stream: FirestoreService().getUserProfile(user.uid),
                  builder: (context, snapshot) {
                    final profile = snapshot.data;
                    final streak = profile?.currentStreak ?? 0;
                    return Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 4),
                              Text(
                                '$streak Günlük Seri',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 700.ms).scale(),
                        const SizedBox(width: 12),
                        Text(
                          'TYT ve AYT sorularıyla kendini sına',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    );
                  },
                )
              else
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
            IconButton(
              icon: const Icon(Icons.leaderboard, color: Colors.amberAccent, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white54),
              onPressed: () async {
                await AuthService().signOut();
              },
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
}
