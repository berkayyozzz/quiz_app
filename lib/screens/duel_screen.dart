import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';
import '../services/ad_manager.dart';
import '../services/quiz_service.dart';
import 'duel_result_screen.dart';

class DuelScreen extends StatefulWidget {
  const DuelScreen({super.key});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> with TickerProviderStateMixin {
  // Matchmaking state
  bool _isSearching = true;
  int _searchSecondsLeft = 10;
  Timer? _searchTimer;

  // Bot info
  String _opponentName = '';
  bool _isBot = true;

  // Duel quiz state
  List<Question> _questions = [];
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _playerScore = 0;
  int _opponentScore = 0;
  int _playerCorrect = 0;
  int _opponentCorrect = 0;
  int _secondsLeft = 15;
  Timer? _questionTimer;
  bool _duelFinished = false;
  int? _botAnsweredIndex;
  double _botSkill = 0.5;
  bool _botAnswered = false;
  int _botTargetSeconds = -1;

  // Animation
  late AnimationController _pulseController;
  late AnimationController _vsController;

  // Random Turkish bot names
  static const List<String> _turkishNames = [
    'Ahmet', 'Mehmet', 'Ayşe', 'Fatma', 'Ali', 'Zeynep', 'Mustafa', 'Emine',
    'Hüseyin', 'Hatice', 'Hasan', 'Elif', 'İbrahim', 'Meryem', 'Yusuf',
    'Zehra', 'Ömer', 'Büşra', 'Osman', 'Sümeyye', 'Emre', 'Esra', 'Can',
    'Derya', 'Berk', 'Selin', 'Cem', 'Gizem', 'Deniz', 'Ece', 'Kaan',
    'İrem', 'Burak', 'Melis', 'Tolga', 'Nur', 'Onur', 'Aslı', 'Serkan',
    'Gamze', 'Furkan', 'Dilan', 'Arda', 'Şeyma', 'Batuhan', 'Tuğçe',
    'Caner', 'Merve', 'Barış', 'Pelin', 'Kerem', 'Simge', 'Çağlar',
    'Beyza', 'Umut', 'Cansu', 'Tuna', 'Ebru', 'Alp', 'Hazal',
    'Yiğit', 'Cemre', 'Doruk', 'Beste', 'Efe', 'Damla',
  ];

  @override
  void initState() {
    super.initState();
    AdManager.loadInterstitialAd();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _vsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _startMatchmaking();
  }

  void _startMatchmaking() {
    _searchSecondsLeft = 10;
    int targetMatchSecond = Random().nextInt(8); // Matches when seconds hit anywhere between 0 and 7 (taking 3 to 10 seconds)
    
    _searchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _searchSecondsLeft--;
      });
      if (_searchSecondsLeft <= targetMatchSecond) {
        timer.cancel();
        _matchWithBot();
      }
    });
  }

  void _matchWithBot() {
    final random = Random();
    final nameIndex = random.nextInt(_turkishNames.length);
    setState(() {
      _isBot = true;
      _opponentName = _turkishNames[nameIndex];
      _isSearching = false;
      _botSkill = 0.3 + random.nextDouble() * 0.6; // Bot skill between 0.3 and 0.9
    });
    _vsController.forward();

    // Load questions
    final quiz = context.read<QuizProvider>();
    _questions = QuizService.getQuestions(
      examType: quiz.examType,
      subject: 'Karışık',
      count: 10,
    );

    // Wait a moment to show VS screen, then start duel
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _startDuel();
      }
    });
  }

  void _startDuel() {
    setState(() {
      _currentIndex = 0;
      _selectedAnswer = null;
      _botAnsweredIndex = null;
      _answered = false;
      _botAnswered = false;
      _botTargetSeconds = -1;
      _secondsLeft = 15;
    });
    _startQuestionTimer();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _secondsLeft--;
      });

      if (_answered && !_botAnswered && _secondsLeft <= _botTargetSeconds) {
        timer.cancel();
        _botAnswered = true;
        _simulateBotAnswer();
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (mounted) _moveToNext();
        });
        return;
      }

      if (_secondsLeft <= 0) {
        timer.cancel();
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    if (!_answered) {
      setState(() {
        _answered = true;
      });
      _botAnswered = true;
      _simulateBotAnswer();
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) _moveToNext();
      });
    } else if (!_botAnswered) {
      _botAnswered = true;
      _simulateBotAnswer();
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) _moveToNext();
      });
    }
  }

  void _handleAnswer(int index) {
    if (_answered || _duelFinished) return;

    final isCorrect = index == _questions[_currentIndex].correctIndex;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (isCorrect) {
        _playerScore += 10;
        _playerCorrect++;
      }
      
      int botWait = Random().nextInt(5); // 0 to 4 seconds
      
      if (botWait == 0) {
        _questionTimer?.cancel();
        _botAnswered = true;
        _simulateBotAnswer();
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (mounted) _moveToNext();
        });
      } else {
        _botTargetSeconds = _secondsLeft - botWait;
        if (_botTargetSeconds < 0) _botTargetSeconds = 0;
      }
    });
  }

  void _simulateBotAnswer() {
    final random = Random();
    final q = _questions[_currentIndex];
    
    // Bot correctness depends on its skill
    final botCorrect = random.nextDouble() < _botSkill;

    setState(() {
      if (botCorrect) {
        _opponentScore += 10;
        _opponentCorrect++;
        _botAnsweredIndex = q.correctIndex;
      } else {
        // Pick a random wrong answer
        List<int> wrongIndices = [];
        for (int i = 0; i < q.options.length; i++) {
          if (i != q.correctIndex) wrongIndices.add(i);
        }
        _botAnsweredIndex = wrongIndices[random.nextInt(wrongIndices.length)];
      }
    });
  }

  void _moveToNext() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _botAnsweredIndex = null;
        _answered = false;
        _botAnswered = false;
        _botTargetSeconds = -1;
        _secondsLeft = 15;
      });
      _startQuestionTimer();
    } else {
      _finishDuel();
    }
  }

  void _finishDuel() {
    _questionTimer?.cancel();
    setState(() {
      _duelFinished = true;
    });

    AdManager.showInterstitialAd(
      onAdDismissed: () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DuelResultScreen(
                playerScore: _playerScore,
                opponentScore: _opponentScore,
                playerCorrect: _playerCorrect,
                opponentCorrect: _opponentCorrect,
                opponentName: _opponentName,
                totalQuestions: _questions.length,
                isBot: _isBot,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _questionTimer?.cancel();
    _pulseController.dispose();
    _vsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearching) {
      return _buildSearchingScreen();
    }

    if (_duelFinished) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0D1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show VS screen before questions start
    if (_questions.isEmpty) {
      return _buildVSScreen();
    }

    return _buildDuelQuizScreen();
  }

  Widget _buildSearchingScreen() {
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
          child: Column(
            children: [
              // Close button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () {
                    _searchTimer?.cancel();
                    Navigator.pop(context);
                  },
                ),
              ),
              const Spacer(),
              // Searching animation
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 140 + (_pulseController.value * 20),
                    height: 140 + (_pulseController.value * 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF4757).withOpacity(0.3),
                          const Color(0xFFFF4757).withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF4757).withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text('⚔️', style: TextStyle(fontSize: 42)),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                'Rakip Aranıyor...',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn().shimmer(duration: 2000.ms, color: Colors.white24),
              const SizedBox(height: 12),
              Text(
                'Tahmini bekleme süresi: $_searchSecondsLeft saniye',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 40),
              // Loading dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF4757).withOpacity(0.6),
                    ),
                  ).animate(
                    onPlay: (c) => c.repeat(),
                  ).scale(
                    delay: (i * 200).ms,
                    duration: 600.ms,
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.2, 1.2),
                  ).then().scale(
                    duration: 600.ms,
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(0.5, 0.5),
                  );
                }),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVSScreen() {
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Player 1
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF3D5AF1)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('👤', style: TextStyle(fontSize: 36)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sen',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).animate().slideX(begin: -0.5).fadeIn(),

                const SizedBox(height: 32),

                // VS
                Text(
                  'VS',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                      ).createShader(const Rect.fromLTWH(0, 0, 100, 60)),
                  ),
                ).animate().scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                ),

                const SizedBox(height: 32),

                // Opponent
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF4757).withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '👤',
                          style: TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _opponentName,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).animate().slideX(begin: 0.5).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDuelQuizScreen() {
    final q = _questions[_currentIndex];
    const primaryColor = Color(0xFFFF4757);

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
          child: Column(
            children: [
              // Top bar with scores
              _buildDuelTopBar(primaryColor),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildSubjectBadge(q.subject, primaryColor),
                        const SizedBox(height: 16),
                        _buildQuestionCard(q.questionText),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: q.options.length,
                          itemBuilder: (_, i) =>
                              _buildOptionTile(i, q.options[i], primaryColor),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuelTopBar(Color primaryColor) {
    final timerColor = _secondsLeft > 8
        ? Colors.greenAccent
        : _secondsLeft > 4
            ? Colors.orange
            : Colors.redAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          // Score row
          Row(
            children: [
              // Player score
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF3D5AF1)],
                        ),
                      ),
                      child: const Center(
                        child: Text('👤', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sen',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white54,
                          ),
                        ),
                        Text(
                          '$_playerScore',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6C63FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Timer & Question count
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: timerColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: timerColor.withOpacity(0.4)),
                    ),
                    child: Text(
                      '$_secondsLeft',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: timerColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_currentIndex + 1}/${_questions.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),

              // Opponent score
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _opponentName,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white54,
                          ),
                        ),
                        Text(
                          '$_opponentScore',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF4757),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '👤',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 4,
            ),
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

  Widget _buildOptionTile(int index, String option, Color primaryColor) {
    final isCorrect = index == _questions[_currentIndex].correctIndex;
    final isSelected = _selectedAnswer == index;

    Color borderColor = Colors.white12;
    Color bgColor = const Color(0xFF1E1E3F);
    Color textColor = Colors.white70;
    IconData? trailingIcon;

    if (_answered) {
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

    final isBotChoice = _answered && _botAnsweredIndex == index;
    final labels = ['A', 'B', 'C', 'D', 'E'];

    return GestureDetector(
      onTap: () => _handleAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 10),
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
                color: _answered && isCorrect
                    ? Colors.green
                    : _answered && isSelected
                        ? Colors.redAccent
                        : primaryColor.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: _answered && (isCorrect || isSelected)
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
            if (isBotChoice)
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text('👤', style: TextStyle(fontSize: 20)),
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
}
