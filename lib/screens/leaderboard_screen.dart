import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/quiz_service.dart';
import 'duel_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final String? _currentUserUid = AuthService().currentUser?.uid;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEditNameDialog() {
    final controller = TextEditingController();
    final currentName = AuthService().currentUser?.displayName ?? '';
    controller.text = currentName;

    showDialog(
      context: context,
      builder: (ctx) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A1A2E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  const Text('✏️', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    'Takma Ad Değiştir',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Liderlik tablosunda görünecek takma adını gir:',
                    style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    maxLength: 20,
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Takma adını yaz...',
                      hintStyle: GoogleFonts.poppins(color: Colors.white30),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                      ),
                      counterStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 11),
                      prefixIcon: const Icon(Icons.person, color: Colors.white38),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(ctx),
                  child: Text('İptal', style: GoogleFonts.poppins(color: Colors.white54)),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final newName = controller.text.trim();
                          if (newName.isEmpty || newName.length < 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Takma ad en az 2 karakter olmalı!'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }
                          setDialogState(() => isLoading = true);
                          final uid = _currentUserUid;
                          if (uid != null) {
                            final success = await _firestoreService.updateDisplayName(uid, newName);
                            if (mounted) {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success
                                      ? 'Takma ad "$newName" olarak güncellendi! ✅'
                                      : 'Takma ad güncellenirken hata oluştu.'),
                                  backgroundColor: success ? Colors.green : Colors.redAccent,
                                ),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Kaydet', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Liderlik Tablosu', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_currentUserUid != null)
            IconButton(
              onPressed: _showEditNameDialog,
              icon: const Icon(Icons.edit, color: Colors.white70),
              tooltip: 'Takma Ad Değiştir',
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF6C63FF),
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          tabs: const [
            Tab(text: '📘 Haftalık Net'),
            Tab(text: '⚔️ Düello Modu'),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D1A), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildWeeklyNetTab(),
              _buildDuelTab(),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== WEEKLY NET TAB ====================
  Widget _buildWeeklyNetTab() {
    return Column(
      children: [
        _buildLastWeekWinner(_firestoreService),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.leaderboard, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text('Haftalık Toplam Net',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              (context as Element).markNeedsBuild();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            backgroundColor: const Color(0xFF16213E),
            color: const Color(0xFF6C63FF),
            child: StreamBuilder<List<UserProfile>>(
              stream: _firestoreService.getWeeklyLeaderboard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                }
                final users = snapshot.data ?? [];
                if (users.isEmpty) return _buildEmptyWidget();
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: users.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isMe = user.uid == _currentUserUid;
                    return _buildWeeklyCard(user, index, isMe);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyCard(UserProfile user, int index, bool isMe) {
    return Card(
      color: isMe ? const Color(0xFF6C63FF).withOpacity(0.2) : const Color(0xFF1E1E3F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isMe ? const Color(0xFF6C63FF) : Colors.white12,
          width: isMe ? 2 : 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: _getRankColor(index),
          radius: 24,
          child: Text('${index + 1}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(user.displayName,
                  style: GoogleFonts.poppins(
                      fontWeight: isMe ? FontWeight.bold : FontWeight.w500, color: Colors.white),
                  overflow: TextOverflow.ellipsis),
            ),
            if (isMe) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: _showEditNameDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white70, size: 14),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text('Toplam Net', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(user.totalNet.toStringAsFixed(2),
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFFFF6B6B))),
            if (!isMe)
              GestureDetector(
                onTap: () => _sendChallenge(user.uid, user.displayName),
                child: Container(
                  margin: const EdgeInsets.top(4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4757).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFF4757).withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('⚔️', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text('Meydan Oku', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            else
              Text('Puan', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white38)),
          ],
        ),
      ),
    );
  }

  // ==================== DUEL TAB ====================
  Widget _buildDuelTab() {
    return Column(
      children: [
        _buildDuelLastWeekWinner(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const Text('⚔️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text('Düello Haftalık Sıralaması',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              (context as Element).markNeedsBuild();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            backgroundColor: const Color(0xFF16213E),
            color: const Color(0xFFFF4757),
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _firestoreService.getWeeklyDuelLeaderboard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _buildEmptyDuelWidget();
                }
                final users = snapshot.data ?? [];
                if (users.isEmpty) return _buildEmptyDuelWidget();
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: users.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isMe = user['uid'] == _currentUserUid;
                    return _buildDuelCard(user, index, isMe);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDuelCard(Map<String, dynamic> user, int index, bool isMe) {
    final wins = user['wins'] ?? 0;
    final losses = user['losses'] ?? 0;
    final draws = user['draws'] ?? 0;
    final duelPoints = user['duelPoints'] ?? 0;

    return Card(
      color: isMe ? const Color(0xFFFF4757).withOpacity(0.15) : const Color(0xFF1E1E3F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isMe ? const Color(0xFFFF4757) : Colors.white12,
          width: isMe ? 2 : 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: _getDuelRankColor(index),
              radius: 22,
              child: Text('${index + 1}',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user['displayName'] ?? 'Misafir',
                      style: GoogleFonts.poppins(
                          fontWeight: isMe ? FontWeight.bold : FontWeight.w500, color: Colors.white, fontSize: 15),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildMiniStat('G', '$wins', Colors.greenAccent),
                      const SizedBox(width: 8),
                      _buildMiniStat('M', '$losses', Colors.redAccent),
                      const SizedBox(width: 8),
                      _buildMiniStat('B', '$draws', Colors.white54),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$duelPoints',
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFFFF4757))),
                if (!isMe)
                  GestureDetector(
                    onTap: () => _sendChallenge(user['uid'], user['displayName'] ?? 'Oyuncu'),
                    child: Container(
                      margin: const EdgeInsets.top(4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4757).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFF4757).withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('⚔️', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text('Meydan Oku', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                else
                  Text('Puan', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white38)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        const SizedBox(width: 2),
        Text(value, style: GoogleFonts.poppins(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDuelLastWeekWinner() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _firestoreService.getLastWeekDuelWinner(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final winner = snapshot.data!;
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFFF4757).withOpacity(0.8), const Color(0xFFFF6B81).withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: const Color(0xFFFF4757).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
            ],
          ),
          child: Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Geçen Hafta Düello Şampiyonu',
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    Text(winner['displayName'] ?? 'Misafir',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('${winner['duelPoints']} Puan • ${winner['wins']} Galibiyet',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==================== SHARED WIDGETS ====================
  Widget _buildLastWeekWinner(FirestoreService firestoreService) {
    return FutureBuilder<UserProfile?>(
      future: firestoreService.getLastWeekWinner(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) return const SizedBox.shrink();
        final winner = snapshot.data!;
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.withOpacity(0.8), Colors.orangeAccent.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.workspace_premium, color: Colors.white, size: 60),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
                      child: Text('ŞAMPİYON',
                          style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Geçen Haftanın Şampiyonu',
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    Text(winner.displayName,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('Skor: ${winner.totalNet.toStringAsFixed(2)} Puan',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text('Veriler yüklenemedi',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text('Hata: $error',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Center(
          child: Column(
            children: [
              const Icon(Icons.emoji_events_outlined, color: Colors.white12, size: 80),
              const SizedBox(height: 16),
              Text('Bu hafta henüz kimse skor kaydetmedi.',
                  style: GoogleFonts.poppins(color: Colors.white38)),
              const SizedBox(height: 8),
              Text('İlk sen olmak ister misin? 🚀',
                  style: GoogleFonts.poppins(color: Colors.white24, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyDuelWidget() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Center(
          child: Column(
            children: [
              const Text('⚔️', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text('Bu hafta henüz düello yapılmadı.',
                  style: GoogleFonts.poppins(color: Colors.white38)),
              const SizedBox(height: 8),
              Text('İlk düelloyu sen başlat! 🔥',
                  style: GoogleFonts.poppins(color: Colors.white24, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRankColor(int index) {
    if (index == 0) return Colors.amber;
    if (index == 1) return Colors.blueGrey[300]!;
    if (index == 2) return Colors.brown[400]!;
    return const Color(0xFF3D5AF1);
  }

  Color _getDuelRankColor(int index) {
    if (index == 0) return const Color(0xFFFF4757);
    if (index == 1) return Colors.blueGrey[300]!;
    if (index == 2) return Colors.brown[400]!;
    return const Color(0xFF3D5AF1);
  }

  Future<void> _sendChallenge(String targetUid, String targetName) async {
    final myUser = AuthService().currentUser;
    if (myUser == null) return;
    
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFFFF4757))),
    );

    final quiz = context.read<QuizProvider>();
    final myProfile = await _firestoreService.getUserProfile(myUser.uid);
    final myName = myProfile?.displayName ?? 'Oyuncu';

    final random = Random();
    final code = (100000 + random.nextInt(900000)).toString();

    final localQuestions = QuizService.getQuestions(
      examType: quiz.examType,
      subject: 'Karışık',
      count: 10,
    );
    final questionMaps = localQuestions.map((q) => q.toMap()).toList();

    // Create room
    final roomData = await _firestoreService.createPrivateRoom(
      uid: myUser.uid,
      displayName: myName,
      examType: quiz.examType,
      roomCode: code,
      questions: questionMaps,
    );

    if (roomData == null) {
      if (mounted) Navigator.pop(context); // close loading
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oda oluşturulamadı.')));
      return;
    }

    // Send invite
    final error = await _firestoreService.sendDuelInvite(
      fromUid: myUser.uid,
      fromName: myName,
      toUid: targetUid,
      roomCode: code,
    );

    if (mounted) Navigator.pop(context); // close loading

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.orange));
      // Cleanup room if failed to send invite
      await _firestoreService.deleteRoom(roomData['roomId']);
      return;
    }

    // Go to DuelScreen waiting
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DuelScreen(initialRoomCode: code),
        ),
      );
    }
  }
}
