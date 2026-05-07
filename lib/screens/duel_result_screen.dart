import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/ad_manager.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/haptic_helper.dart';
import '../services/quiz_service.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'duel_screen.dart';
import 'home_screen.dart';
import 'leaderboard_screen.dart';

class DuelResultScreen extends StatefulWidget {
  final int playerScore;
  final int opponentScore;
  final int playerCorrect;
  final int opponentCorrect;
  final String opponentName;
  final int totalQuestions;
  final bool isBot;
  final String? roomId;
  final String? myPlayerKey;
  final String? opponentPlayerKey;

  const DuelResultScreen({
    super.key,
    required this.playerScore,
    required this.opponentScore,
    required this.playerCorrect,
    required this.opponentCorrect,
    required this.opponentName,
    required this.totalQuestions,
    required this.isBot,
    this.roomId,
    this.myPlayerKey,
    this.opponentPlayerKey,
  });

  @override
  State<DuelResultScreen> createState() => _DuelResultScreenState();
}

class _DuelResultScreenState extends State<DuelResultScreen> {
  bool _scoreSaved = false;
  bool _isSaving = false;

  // Rematch
  bool _rematchSent = false;
  bool _rematchLoading = false;
  StreamSubscription<DocumentSnapshot>? _rematchSub;

  @override
  void initState() {
    super.initState();
    _saveDuelScore();

    // Haptic on result
    final playerWon = widget.playerScore > widget.opponentScore;
    if (playerWon) {
      HapticHelper.heavyImpact();
    } else {
      HapticHelper.lightImpact();
    }

    // Listen for incoming rematch requests from opponent
    _listenForRematch();
  }

  @override
  void dispose() {
    _rematchSub?.cancel();
    super.dispose();
  }

  void _listenForRematch() {
    if (widget.roomId == null || widget.isBot) return;

    _rematchSub = FirestoreService().listenToRoom(widget.roomId!).listen((snapshot) {
      if (!mounted) return;
      if (!snapshot.exists) return;

      final data = snapshot.data() as Map<String, dynamic>;
      final rematchRoomId = data['rematchRoomId'] as String?;
      final requestedBy = data['rematchRequestedBy'] as String?;

      // If the OTHER player requested a rematch, show dialog
      if (rematchRoomId != null && requestedBy != null && requestedBy != widget.myPlayerKey) {
        _rematchSub?.cancel();
        _showRematchDialog(rematchRoomId);
      }
    });
  }

  void _showRematchDialog(String newRoomCode) {
    if (!mounted) return;
    HapticHelper.mediumImpact();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E3F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '🔄 Rövanş İsteği!',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '${widget.opponentName} seni tekrar düelloya çağırıyor!',
          style: GoogleFonts.poppins(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'Reddet',
              style: GoogleFonts.poppins(color: Colors.redAccent),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DuelScreen(initialJoinCode: newRoomCode),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Kabul Et',
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendRematch() async {
    if (_rematchSent || _rematchLoading) return;
    if (widget.roomId == null || widget.isBot) return;

    setState(() => _rematchLoading = true);

    try {
      final user = AuthService().currentUser;
      final userProfile = await FirestoreService().getUserProfile(user!.uid);
      final displayName = userProfile?.displayName ?? 'Oyuncu';
      final quiz = context.read<QuizProvider>();

      final random = Random();
      final code = (100000 + random.nextInt(900000)).toString();

      final localQuestions = QuizService.getQuestions(
        examType: quiz.examType,
        subject: 'Karışık',
        count: 10,
      );
      final questionMaps = localQuestions.map((q) => q.toMap()).toList();

      final roomData = await FirestoreService().createPrivateRoom(
        uid: user.uid,
        displayName: displayName,
        examType: quiz.examType,
        roomCode: code,
        questions: questionMaps,
      );

      if (roomData != null) {
        // Tell the old room about the rematch
        await FirestoreService().requestRematch(
          widget.roomId!,
          code,
          widget.myPlayerKey!,
        );

        setState(() {
          _rematchSent = true;
          _rematchLoading = false;
        });

        HapticHelper.mediumImpact();

        // Navigate to the new room as player1
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DuelScreen(initialRoomCode: code),
            ),
          );
        }
      } else {
        setState(() => _rematchLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _rematchLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rövanş isteği gönderilemedi.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _saveDuelScore() async {
    if (_isSaving) return;

    final authService = AuthService();
    final user = authService.currentUser;
    if (user == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final firestoreService = FirestoreService();
      final profile = await firestoreService.getUserProfile(user.uid);
      final displayName = profile?.displayName ??
          user.displayName ??
          'Misafir-${(user.uid.length >= 5) ? user.uid.substring(0, 5) : user.uid}';

      final playerWon = widget.playerScore > widget.opponentScore;
      final isDraw = widget.playerScore == widget.opponentScore;
      final duelPoints = playerWon ? 3 : (isDraw ? 1 : 0);

      await firestoreService.saveDuelResult(
        uid: user.uid,
        displayName: displayName,
        duelPoints: duelPoints,
        won: playerWon,
        isDraw: isDraw,
      );

      if (mounted) {
        setState(() {
          _scoreSaved = true;
          _isSaving = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerWon = widget.playerScore > widget.opponentScore;
    final isDraw = widget.playerScore == widget.opponentScore;
    final isOnlineMatch = widget.roomId != null && !widget.isBot;

    String emoji;
    String title;
    String subtitle;
    List<Color> gradientColors;

    if (playerWon) {
      emoji = '🏆';
      title = 'Kazandın!';
      subtitle = 'Harika bir düello performansı!';
      gradientColors = [const Color(0xFFFFD700), const Color(0xFFFFA500)];
    } else if (isDraw) {
      emoji = '🤝';
      title = 'Berabere!';
      subtitle = 'Çok yakın bir mücadele!';
      gradientColors = [const Color(0xFF6C63FF), const Color(0xFF3D5AF1)];
    } else {
      emoji = '😤';
      title = 'Kaybettin!';
      subtitle = 'Bir sonraki sefere daha güçlü!';
      gradientColors = [const Color(0xFFFF4757), const Color(0xFFFF6B81)];
    }

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Result emoji
                Text(emoji, style: const TextStyle(fontSize: 72))
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.elasticOut),

                const SizedBox(height: 16),

                // Title
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: gradientColors,
                  ).createShader(bounds),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms),

                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 32),

                // Score comparison card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.15),
                        gradientColors[1].withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: gradientColors[0].withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // VS Header
                      Row(
                        children: [
                          // Player
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6C63FF), Color(0xFF3D5AF1)],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6C63FF).withOpacity(0.4),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text('👤', style: TextStyle(fontSize: 28)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Sen',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // VS
                          Text(
                            'VS',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white38,
                            ),
                          ),

                          // Opponent
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF4757).withOpacity(0.4),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                    child: const Center(
                                      child: Text(
                                        '👤',
                                        style: TextStyle(fontSize: 28),
                                      ),
                                    ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.opponentName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Score comparison
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.playerScore}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                          Text(
                            '-',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white38,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.opponentScore}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFFF4757),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(color: Colors.white12, height: 32),

                      // Stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatColumn(
                              '${widget.playerCorrect}/${widget.totalQuestions}',
                              'Doğru',
                              const Color(0xFF6C63FF),
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.white12),
                          Expanded(
                            child: _buildStatColumn(
                              '${widget.opponentCorrect}/${widget.totalQuestions}',
                              'Doğru',
                              const Color(0xFFFF4757),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 0.2, delay: 400.ms).fadeIn(),

                const SizedBox(height: 20),

                // Points earned
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        playerWon
                            ? '+3 Düello Puanı'
                            : isDraw
                                ? '+1 Düello Puanı'
                                : '+0 Düello Puanı',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: playerWon
                              ? Colors.amber
                              : isDraw
                                  ? Colors.blueAccent
                                  : Colors.white54,
                        ),
                      ),
                      if (_scoreSaved) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
                      ],
                    ],
                  ),
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 16),

                // Rematch button (only for online matches)
                if (isOnlineMatch) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00B894).withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _rematchLoading || _rematchSent ? null : _sendRematch,
                        icon: _rematchLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Icon(
                                _rematchSent ? Icons.check : Icons.replay,
                                color: Colors.white,
                              ),
                        label: Text(
                          _rematchSent ? 'Rövanş İsteği Gönderildi!' : 'Rövanş İste 🔄',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 650.ms),
                  const SizedBox(height: 12),
                ],

                // Leaderboard button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                      );
                    },
                    icon: const Icon(Icons.leaderboard, size: 18),
                    label: Text(
                      'Düello Sıralamasını Gör',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.withOpacity(0.2),
                      foregroundColor: Colors.amber,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: Colors.amber.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 700.ms),

                const SizedBox(height: 32),

                // Replay button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const DuelScreen()),
                        );
                      },
                      icon: const Icon(Icons.replay, color: Colors.white),
                      label: Text(
                        'Tekrar Düello',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms),

                const SizedBox(height: 12),

                // Home button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (_) => false,
                      );
                    },
                    icon: const Icon(Icons.home, color: Colors.white54),
                    label: Text(
                      'Ana Sayfa',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 900.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
