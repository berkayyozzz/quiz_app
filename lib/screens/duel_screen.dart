import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';
import '../services/ad_manager.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/haptic_helper.dart';
import '../services/premium_service.dart';
import '../services/quiz_service.dart';
import '../widgets/native_ad_widget.dart';
import 'duel_result_screen.dart';

class DuelScreen extends StatefulWidget {
  final String? initialRoomCode; // If we created a room and are waiting
  final String? initialJoinCode; // If we are joining an invite

  const DuelScreen({super.key, this.initialRoomCode, this.initialJoinCode});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> with TickerProviderStateMixin {
  // Ticket state
  bool _isCheckingTickets = true;
  bool _hasTickets = false;
  bool _isRewardLoading = false;

  // Matchmaking / Online State
  bool _showMenu = false;
  bool _showJoinRoom = false;
  final TextEditingController _roomCodeController = TextEditingController();
  bool _isSearching = false;
  int _searchSecondsLeft = 15;
  Timer? _searchTimer;
  String? _roomId;
  StreamSubscription<DocumentSnapshot>? _roomSubscription;
  bool _isOnline = false;
  String _myPlayerKey = 'player1';
  String _opponentPlayerKey = 'player2';
  bool _isCreatingRoom = false;
  String? _myRoomCode;

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
  
  int? _opponentAnswerIndex;
  bool _opponentAnswered = false;
  bool _waitingForOpponent = false;

  // Emojis
  final List<Map<String, dynamic>> _activeEmojiReactions = [];
  Timer? _emojiTimer;
  String? _lastOpponentEmojiRaw;
  bool _emojiCooldown = false;
  int _emojiReactionKey = 0;

  // Animation
  late AnimationController _pulseController;
  late AnimationController _vsController;

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

    _checkTickets();
  }

  Future<void> _checkTickets() async {
    final authService = AuthService();
    final user = authService.currentUser;
    
    if (user != null) {
      // Premium kullanıcılar sınırsız düello hakkına sahip
      final isPremium = PremiumService().isPremium;
      final hasTicket = isPremium ? true : await FirestoreService().hasDuelTickets(user.uid);
      if (mounted) {
        setState(() {
          _isCheckingTickets = false;
          _hasTickets = hasTicket;
          if (hasTicket) {
             if (widget.initialJoinCode != null) {
                // Instantly join
                _joinPrivateRoom(widget.initialJoinCode!);
             } else if (widget.initialRoomCode != null) {
                // Instantly wait
                _myRoomCode = widget.initialRoomCode;
                _showMenu = false;
                _roomId = widget.initialRoomCode; // the room ID is the code for private rooms
                _myPlayerKey = 'player1';
                _opponentPlayerKey = 'player2';
                _isSearching = true; // waiting state
                _listenToRoom();
             } else {
                _showMenu = true;
             }
          }
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isCheckingTickets = false;
          _hasTickets = false;
        });
      }
    }
  }

  void _watchRewardedAdForTickets() async {
    setState(() {
      _isRewardLoading = true;
    });

    if (!AdManager.isRewardedAdLoaded) {
      await Future.delayed(const Duration(seconds: 2));
    }

    AdManager.showRewardedAd(
      onRewarded: () async {
        final user = AuthService().currentUser;
        if (user != null) {
          final success = await FirestoreService().rewardDuelTickets(user.uid);
          if (mounted) {
            setState(() {
              _isRewardLoading = false;
            });
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('+3 Düello Hakkı Kazandınız! 🎉'),
                  backgroundColor: Colors.green,
                ),
              );
              setState(() {
                _isCheckingTickets = true;
              });
              _checkTickets();
            }
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
              content: Text('Reklam yüklenemedi. Daha sonra tekrar deneyin.'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      },
    );
  }

  // --- Matchmaking & Online Logic ---

  Future<void> _startRandomMatchmaking() async {
    final user = AuthService().currentUser;
    final userProfile = await FirestoreService().getUserProfile(user!.uid);
    final displayName = userProfile?.displayName ?? 'Oyuncu';
    final quiz = context.read<QuizProvider>();

    setState(() {
      _showMenu = false;
      _isSearching = true;
      _searchSecondsLeft = 15;
    });

    // Create 10 local questions first to use if we create the room
    final localQuestions = QuizService.getQuestions(
      examType: quiz.examType,
      subject: 'Karışık',
      count: 10,
    );
    final questionMaps = localQuestions.map((q) => q.toMap()).toList();

    final roomData = await FirestoreService().findOrWaitMatch(
      uid: user.uid,
      displayName: displayName,
      examType: quiz.examType,
      questions: questionMaps,
    );

    if (roomData == null) {
      // Something went wrong, fallback to bot
      _matchWithBot();
      return;
    }

    _roomId = roomData['roomId'];

    if (roomData['player2Id'] != null) {
      // Joined an existing room
      _isOnline = true;
      _isBot = false;
      _myPlayerKey = 'player2';
      _opponentPlayerKey = 'player1';
      _opponentName = roomData['player1Name'];
      _loadQuestionsFromRoom(roomData['questions']);
      
      _listenToRoom();
      _showVSScreen();
    } else {
      // Created a new room, wait for someone to join
      _myPlayerKey = 'player1';
      _opponentPlayerKey = 'player2';
      _loadQuestionsFromRoom(roomData['questions']);
      _listenToRoom();

      _searchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          _cleanupRoom();
          return;
        }
        setState(() {
          _searchSecondsLeft--;
        });

        if (_searchSecondsLeft <= 0) {
          timer.cancel();
          if (_isSearching) {
            // Timeout, fallback to bot
            _cleanupRoom();
            _matchWithBot();
          }
        }
      });
    }
  }

  void _loadQuestionsFromRoom(List<dynamic> qList) {
    _questions = qList.map((q) => Question.fromMap(Map<String, dynamic>.from(q))).toList();
  }

  void _listenToRoom() {
    if (_roomId == null) return;

    _roomSubscription = FirestoreService().listenToRoom(_roomId!).listen((snapshot) {
      if (!mounted) return;
      if (!snapshot.exists) {
        // Room was deleted – opponent left
        _handleOpponentLeft();
        return;
      }

      final data = snapshot.data() as Map<String, dynamic>;

      // Detect opponent leaving (their ID was cleared or room marked abandoned)
      if (_isOnline && !_isSearching && !_duelFinished) {
        final oppId = data['${_opponentPlayerKey}Id'];
        if (data['status'] == 'abandoned' || (oppId == null && !_isSearching)) {
          _handleOpponentLeft();
          return;
        }
      }

      // Check if someone joined while we were searching
      if (_isSearching && data['status'] == 'playing' && data['player2Id'] != null) {
        _searchTimer?.cancel();
        setState(() {
          _isSearching = false;
          _isOnline = true;
          _isBot = false;
          _opponentName = data['player2Name'];
        });
        _showVSScreen();
      }

      // Update opponent score during game
      if (_isOnline && !_isSearching) {
        setState(() {
          _opponentScore = data['${_opponentPlayerKey}Score'] ?? 0;
          _opponentCorrect = data['${_opponentPlayerKey}Correct'] ?? 0;

          if (data.containsKey('${_opponentPlayerKey}AnswerIndex')) {
            final ans = data['${_opponentPlayerKey}AnswerIndex'];
            if (ans != null && !_opponentAnswered) {
              _opponentAnswered = true;
              _opponentAnswerIndex = ans;
              _checkBothAnswered();
            }
          }

          final oppEmojiRaw = data['${_opponentPlayerKey}Emoji'] as String?;
          if (oppEmojiRaw != null && oppEmojiRaw != _lastOpponentEmojiRaw) {
             _lastOpponentEmojiRaw = oppEmojiRaw;
             final emoji = oppEmojiRaw.split('_')[0];
             _showEmojiAnimation(emoji, isFromMe: false);
          }
        });
      }
    });
  }

  Future<void> _cleanupRoom() async {
    _roomSubscription?.cancel();
    _emojiTimer?.cancel();
    if (_roomId != null && _myPlayerKey == 'player1' && (_isSearching || _isCreatingRoom)) {
       await FirestoreService().deleteRoom(_roomId!);
    }
    _roomId = null;
  }

  bool _opponentLeftHandled = false;

  void _handleOpponentLeft() {
    if (_opponentLeftHandled || _duelFinished) return;
    _opponentLeftHandled = true;
    _questionTimer?.cancel();
    _roomSubscription?.cancel();
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rakip oyundan ayrıldı! Kalan sorular rakibe yanlış sayılacak.', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.orangeAccent,
        duration: const Duration(seconds: 3),
      ),
    );

    // Treat all remaining questions as opponent wrong, finish the duel
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _finishDuel();
    });
  }

  void _showEmojiAnimation(String emoji, {bool isFromMe = false}) {
    final reaction = {
      'emoji': emoji,
      'isFromMe': isFromMe,
      'key': _emojiReactionKey++,
      'timestamp': DateTime.now(),
    };
    setState(() {
      _activeEmojiReactions.add(reaction);
    });
    // Remove after animation completes
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _activeEmojiReactions.removeWhere((r) => r['key'] == reaction['key']);
        });
      }
    });
  }

  void _sendEmoji(String e) {
     if (_emojiCooldown) return;
     
     if (_isOnline && _roomId != null) {
       FirestoreService().updateRoomEmoji(_roomId!, _myPlayerKey, '${e}_${DateTime.now().millisecondsSinceEpoch}');
     }
     // Show the emoji locally with sender info
     _showEmojiAnimation(e, isFromMe: true);
     HapticHelper.mediumImpact();
     
     // Cooldown to prevent spam
     setState(() => _emojiCooldown = true);
     Future.delayed(const Duration(seconds: 2), () {
       if (mounted) setState(() => _emojiCooldown = false);
     });
  }

  Future<void> _createPrivateRoom() async {
    final user = AuthService().currentUser;
    final userProfile = await FirestoreService().getUserProfile(user!.uid);
    final displayName = userProfile?.displayName ?? 'Oyuncu';
    final quiz = context.read<QuizProvider>();

    setState(() {
      _isCreatingRoom = true;
    });

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

    setState(() {
      _isCreatingRoom = false;
    });

    if (roomData != null) {
      setState(() {
        _myRoomCode = code;
        _showMenu = false;
        _roomId = roomData['roomId'];
        _myPlayerKey = 'player1';
        _opponentPlayerKey = 'player2';
        _isSearching = true; // reusing searching flag for waiting state
      });
      _loadQuestionsFromRoom(roomData['questions']);
      _listenToRoom();
    }
  }

  Future<void> _joinPrivateRoom(String code) async {
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Oda kodu 6 haneli olmalıdır.'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    final user = AuthService().currentUser;
    final userProfile = await FirestoreService().getUserProfile(user!.uid);
    final displayName = userProfile?.displayName ?? 'Oyuncu';

    final result = await FirestoreService().joinPrivateRoom(
      roomCode: code,
      uid: user.uid,
      displayName: displayName,
    );

    if (result != null && result.containsKey('error')) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error']), backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (result != null) {
      _roomId = result['roomId'];
      _isOnline = true;
      _isBot = false;
      _myPlayerKey = 'player2';
      _opponentPlayerKey = 'player1';
      _opponentName = result['player1Name'];
      _loadQuestionsFromRoom(result['questions']);
      
      setState(() {
        _showJoinRoom = false;
        _showMenu = false;
      });
      
      _listenToRoom();
      _showVSScreen();
    }
  }


  void _matchWithBot() {
    final random = Random();
    final nameIndex = random.nextInt(_turkishNames.length);
    
    if (_questions.isEmpty) {
      final quiz = context.read<QuizProvider>();
      _questions = QuizService.getQuestions(
        examType: quiz.examType,
        subject: 'Karışık',
        count: 10,
      );
    }

    setState(() {
      _isBot = true;
      _isOnline = false;
      _opponentName = _turkishNames[nameIndex];
      _isSearching = false;
      _botSkill = 0.3 + random.nextDouble() * 0.6; 
    });
    
    _showVSScreen();
  }

  void _showVSScreen() {
    _vsController.forward();
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

      if (_secondsLeft <= 3 && _secondsLeft > 0 && !_answered) {
         HapticHelper.selectionClick();
      }

      if (_isBot && _answered && !_botAnswered && _secondsLeft <= _botTargetSeconds) {
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

  void _checkBothAnswered() {
    if (_isBot) return;
    if (_answered && _opponentAnswered && _waitingForOpponent) {
      setState(() {
        _waitingForOpponent = false;
      });
      _questionTimer?.cancel();
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) _moveToNext();
      });
    }
  }

  void _handleTimeUp() {
    if (!_answered) {
      setState(() {
        _answered = true;
        _selectedAnswer = -1;
      });
      _handleOnlineUpdate(answerIndex: -1);
      
      if (_isBot) {
         _botAnswered = true;
         _simulateBotAnswer();
         Future.delayed(const Duration(milliseconds: 2500), () {
           if (mounted) _moveToNext();
         });
      } else {
         // Online mode: if opponent also hasn't answered, treat as both wrong and move on
         if (!_opponentAnswered) {
           setState(() {
             _opponentAnswered = true;
             _opponentAnswerIndex = -1; // opponent didn't answer
             _waitingForOpponent = false;
           });
           Future.delayed(const Duration(milliseconds: 2500), () {
             if (mounted) _moveToNext();
           });
         } else {
           // Opponent already answered, just move on
           setState(() {
             _waitingForOpponent = false;
           });
           Future.delayed(const Duration(milliseconds: 2500), () {
             if (mounted) _moveToNext();
           });
         }
      }
    } else if (_isBot && !_botAnswered) {
      _botAnswered = true;
      _simulateBotAnswer();
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) _moveToNext();
      });
    } else if (!_isBot && _waitingForOpponent && !_opponentAnswered) {
      // Online mode: player already answered, timer ran out, opponent still hasn't responded
      setState(() {
        _opponentAnswered = true;
        _opponentAnswerIndex = -1; // opponent didn't answer (or left)
        _waitingForOpponent = false;
      });
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
        HapticHelper.mediumImpact();
        _playerScore += 10;
        _playerCorrect++;
      } else {
        HapticHelper.heavyImpact();
      }
      
      _handleOnlineUpdate(answerIndex: index);

      if (_isBot) {
        int botWait = Random().nextInt(5);
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
      } else {
         _waitingForOpponent = true;
         _checkBothAnswered();
      }
    });
  }

  void _handleOnlineUpdate({int? answerIndex}) {
    if (_isOnline && _roomId != null) {
      FirestoreService().updateRoomScore(
        roomId: _roomId!,
        playerKey: _myPlayerKey,
        score: _playerScore,
        correct: _playerCorrect,
        answerIndex: answerIndex,
      );
    }
  }

  void _simulateBotAnswer() {
    final random = Random();
    final q = _questions[_currentIndex];
    final botCorrect = random.nextDouble() < _botSkill;

    setState(() {
      if (botCorrect) {
        _opponentScore += 10;
        _opponentCorrect++;
        _botAnsweredIndex = q.correctIndex;
      } else {
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
        
        _opponentAnswerIndex = null;
        _opponentAnswered = false;
        _waitingForOpponent = false;
      });
      HapticHelper.selectionClick();
      _handleOnlineUpdate(answerIndex: null);
      _startQuestionTimer();
    } else {
      _finishDuel();
    }
  }

  void _finishDuel() {
    _questionTimer?.cancel();
    _roomSubscription?.cancel();
    _emojiTimer?.cancel();
    
    // If online, we don't delete the room immediately, let both players see it finished
    // In a full implementation, we might clean it up or mark it finished.

    setState(() {
      _duelFinished = true;
    });

    final user = AuthService().currentUser;
    if (user != null && !PremiumService().isPremium) {
       FirestoreService().consumeDuelTicket(user.uid);
    }

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
                roomId: _isOnline ? _roomId : null,
                myPlayerKey: _isOnline ? _myPlayerKey : null,
                opponentPlayerKey: _isOnline ? _opponentPlayerKey : null,
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
    _emojiTimer?.cancel();
    _pulseController.dispose();
    _vsController.dispose();
    _cleanupRoom();
    _roomCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingTickets) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0D1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasTickets) {
      return _buildNoTicketsScreen();
    }

    if (_showMenu) {
      return _buildMenuScreen();
    }

    if (_myRoomCode != null && _isSearching) {
      return _buildWaitingRoomScreen();
    }

    if (_isSearching) {
      return _buildSearchingScreen();
    }

    if (_duelFinished) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0D1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty || (!_isSearching && _selectedAnswer == null && _currentIndex == 0 && !_answered && _secondsLeft == 15 && !_vsController.isCompleted)) {
      return _buildVSScreen();
    }

    return _buildDuelQuizScreen();
  }

  Widget _buildMenuScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white54),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
              Center(
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
                        color: const Color(0xFFFF4757).withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('⚔️', style: TextStyle(fontSize: 40)),
                  ),
                ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Düello Modu',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Gerçek rakiplere veya arkadaşlarına karşı yarış!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              if (!_showJoinRoom) ...[
                _buildMenuButton(
                  title: 'Rastgele Rakip Bul',
                  icon: '🌍',
                  colors: [const Color(0xFF6C63FF), const Color(0xFF3D5AF1)],
                  onTap: _startRandomMatchmaking,
                ),
                const SizedBox(height: 16),
                _buildMenuButton(
                  title: 'Oda Kur (Arkadaşınla Oyna)',
                  icon: '🏠',
                  colors: [const Color(0xFFFF9F43), const Color(0xFFFFC312)],
                  onTap: _isCreatingRoom ? null : _createPrivateRoom,
                  isLoading: _isCreatingRoom,
                ),
                const SizedBox(height: 16),
                _buildMenuButton(
                  title: 'Odaya Katıl',
                  icon: '🔑',
                  colors: [const Color(0xFF10AC84), const Color(0xFF1DD1A1)],
                  onTap: () {
                    setState(() {
                      _showJoinRoom = true;
                    });
                  },
                ),
              ] else ...[
                 Text(
                  'Oda Kodunu Girin:',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _roomCodeController,
                  style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 8, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '000000',
                    hintStyle: const TextStyle(color: Colors.white38, letterSpacing: 8),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showJoinRoom = false;
                            _roomCodeController.clear();
                          });
                        },
                        child: Text('İptal', style: GoogleFonts.poppins(color: Colors.white54)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _joinPrivateRoom(_roomCodeController.text.trim()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10AC84),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text('Katıl', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              const NativeAdWidget(height: 280),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String title,
    required String icon,
    required List<Color> colors,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                )
              else ...[
                Text(icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }


  Widget _buildWaitingRoomScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  _cleanupRoom();
                  setState(() {
                    _myRoomCode = null;
                    _showMenu = true;
                    _isSearching = false;
                  });
                },
              ),
            ),
            const Spacer(),
            Text(
              'Oda Kodunuz',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFF9F43).withOpacity(0.5), width: 2),
              ),
              child: Text(
                _myRoomCode ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 12,
                  color: const Color(0xFFFF9F43),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Arkadaşınızın katılmasını bekleniyor...',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 0.4, end: 1.0),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---
  Widget _buildNoTicketsScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber.withOpacity(0.1),
                ),
                child: const Center(
                  child: Text('🎟️', style: TextStyle(fontSize: 60)),
                ),
              ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text(
                'Düello Hakkınız Bitti',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Günde 3 ücretsiz düello hakkınız bulunur. Reklam izleyerek hemen 3 düello hakkı kazanabilirsiniz.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
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
                  onPressed: _isRewardLoading ? null : _watchRewardedAdForTickets,
                  icon: _isRewardLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black87),
                        )
                      : const Text('🎬', style: TextStyle(fontSize: 20)),
                  label: Text(
                    _isRewardLoading ? 'Yükleniyor...' : 'Reklam İzle +3 Hak',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
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
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () {
                    _searchTimer?.cancel();
                    _cleanupRoom();
                    setState(() {
                      _isSearching = false;
                      _showMenu = true;
                    });
                  },
                ),
              ),
              const Spacer(),
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
                      child: Center(
                        child: Text(
                          '👤',
                          style: const TextStyle(fontSize: 36),
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
      body: Stack(
        children: [
          Container(
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
                            _buildEmojiBar(),
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
          // Emoji reaction overlays
          ..._activeEmojiReactions.map((reaction) {
            final isFromMe = reaction['isFromMe'] as bool;
            final emoji = reaction['emoji'] as String;
            final key = reaction['key'] as int;
            final emojiInfo = _getEmojiInfo(emoji);
            return _buildEmojiOverlay(emoji, emojiInfo, isFromMe, key);
          }),
        ],
      ),
    );
  }

  Map<String, dynamic> _getEmojiInfo(String emoji) {
    switch (emoji) {
      case '👍': return {'label': 'Aferin!', 'color': const Color(0xFF4CAF50), 'bgGlow': const Color(0xFF4CAF50)};
      case '😢': return {'label': 'Üzgünüm...', 'color': const Color(0xFF42A5F5), 'bgGlow': const Color(0xFF1E88E5)};
      case '🤯': return {'label': 'İnanılmaz!', 'color': const Color(0xFFFF9800), 'bgGlow': const Color(0xFFFF6F00)};
      case '🔥': return {'label': 'Yanıyorsun!', 'color': const Color(0xFFFF5722), 'bgGlow': const Color(0xFFD84315)};
      case '😎': return {'label': 'Çok Kolay!', 'color': const Color(0xFF9C27B0), 'bgGlow': const Color(0xFF7B1FA2)};
      case '💀': return {'label': 'Bitti Senin İçin', 'color': const Color(0xFF607D8B), 'bgGlow': const Color(0xFF455A64)};
      default: return {'label': '', 'color': Colors.white, 'bgGlow': Colors.white24};
    }
  }

  Widget _buildEmojiOverlay(String emoji, Map<String, dynamic> info, bool isFromMe, int key) {
    final senderName = isFromMe ? 'Sen' : _opponentName;
    final Color glowColor = info['bgGlow'] as Color;
    final Color labelColor = info['color'] as Color;
    final String label = info['label'] as String;

    return Positioned.fill(
      key: ValueKey('emoji_overlay_$key'),
      child: IgnorePointer(
        child: Stack(
          children: [
            // Background glow pulse
            Positioned.fill(
              child: Container(
                color: glowColor.withOpacity(0.08),
              ).animate()
                .fadeIn(duration: 200.ms)
                .fadeOut(delay: 2000.ms, duration: 800.ms),
            ),
            // Main emoji + label in center
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sender badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: (isFromMe ? const Color(0xFF6C63FF) : const Color(0xFFFF4757)).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      senderName,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ).animate()
                    .fadeIn(duration: 200.ms)
                    .slideY(begin: 0.3)
                    .fadeOut(delay: 2200.ms, duration: 500.ms),
                  const SizedBox(height: 8),
                  // Big emoji
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 80),
                  ).animate()
                    .scale(begin: const Offset(0.2, 0.2), end: const Offset(1.0, 1.0), duration: 400.ms, curve: Curves.elasticOut)
                    .fadeOut(delay: 2000.ms, duration: 800.ms),
                  const SizedBox(height: 4),
                  // Label text
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: labelColor,
                      shadows: [
                        Shadow(color: labelColor.withOpacity(0.5), blurRadius: 12),
                      ],
                    ),
                  ).animate()
                    .fadeIn(delay: 200.ms, duration: 300.ms)
                    .slideY(begin: 0.3)
                    .fadeOut(delay: 2000.ms, duration: 500.ms),
                ],
              ),
            ),
            // Floating mini emojis (particles)
            ...List.generate(6, (i) {
              final random = Random();
              final startX = 40.0 + random.nextDouble() * (MediaQuery.of(context).size.width - 80);
              final startY = MediaQuery.of(context).size.height * 0.3 + random.nextDouble() * MediaQuery.of(context).size.height * 0.4;
              return Positioned(
                left: startX,
                top: startY,
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: 20 + random.nextDouble() * 16),
                ).animate(delay: (i * 150).ms)
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0, end: -2.0 - random.nextDouble() * 2, duration: (1500 + random.nextInt(1000)).ms, curve: Curves.easeOut)
                  .fadeOut(delay: (1200 + random.nextInt(600)).ms, duration: 500.ms)
                  .rotate(begin: -0.1 + random.nextDouble() * 0.2, end: -0.3 + random.nextDouble() * 0.6),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiBar() {
    final emojiData = [
      {'emoji': '👍', 'label': 'Aferin'},
      {'emoji': '😢', 'label': 'Üzgünüm'},
      {'emoji': '🤯', 'label': 'Vay!'},
      {'emoji': '🔥', 'label': 'Ateş'},
      {'emoji': '😎', 'label': 'Kolay'},
      {'emoji': '💀', 'label': 'GG'},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Text(
            'Tepki Gönder',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: _emojiCooldown ? Colors.white24 : Colors.white38,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: emojiData.map((data) {
              final emoji = data['emoji'] as String;
              final label = data['label'] as String;
              final info = _getEmojiInfo(emoji);
              final Color color = info['color'] as Color;
              return Expanded(
                child: GestureDetector(
                  onTap: _emojiCooldown ? null : () => _sendEmoji(emoji),
                  child: AnimatedOpacity(
                    opacity: _emojiCooldown ? 0.3 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withOpacity(0.1),
                            border: Border.all(color: color.withOpacity(0.25)),
                          ),
                          child: Center(
                            child: Text(emoji, style: const TextStyle(fontSize: 24)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
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
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _waitingForOpponent ? 'Bekleniyor...' : _opponentName,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: _waitingForOpponent ? Colors.orangeAccent : Colors.white54,
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF4757), Color(0xFFFF6B81)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '👤',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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

    final isBotChoice = _isBot && _answered && _botAnsweredIndex == index;
    final showOpponentAnswer = !_isBot && _answered && _opponentAnswered && _opponentAnswerIndex == index;
    final isOpponentChoice = isBotChoice || showOpponentAnswer;
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
            if (isOpponentChoice)
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
