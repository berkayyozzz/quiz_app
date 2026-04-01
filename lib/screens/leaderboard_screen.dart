import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    final currentUserUid = AuthService().currentUser?.uid;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Liderlik Tablosu',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          child: Column(
            children: [
              // Last Week's Winner Section
              _buildLastWeekWinner(firestoreService),
              
              const SizedBox(height: 16),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.leaderboard, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Haftalık Toplam Net',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // This will trigger a rebuild of the StreamBuilder
                    (context as Element).markNeedsBuild();
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  backgroundColor: const Color(0xFF16213E),
                  color: const Color(0xFF6C63FF),
                  child: StreamBuilder<List<UserProfile>>(
                    stream: firestoreService.getWeeklyLeaderboard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                  
                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                                const SizedBox(height: 16),
                                Text(
                                  'Veriler yüklenemedi',
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Hata: ${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () => (context as Element).markNeedsBuild(),
                                  child: const Text('Tekrar Dene'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  
                      final users = snapshot.data ?? [];
                  
                      if (users.isEmpty) {
                        return ListView( // Use ListView for RefreshIndicator to work
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                            Center(
                              child: Column(
                                children: [
                                  const Icon(Icons.emoji_events_outlined, color: Colors.white12, size: 80),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Bu hafta henüz kimse skor kaydetmedi.',
                                    style: GoogleFonts.poppins(color: Colors.white38),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'İlk sen olmak ister misin? 🚀',
                                    style: GoogleFonts.poppins(color: Colors.white24, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                  
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: users.length,
                        physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final isMe = user.uid == currentUserUid;
                  
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
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              title: Text(
                                user.displayName,
                                style: GoogleFonts.poppins(
                                  fontWeight: isMe ? FontWeight.bold : FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                'Toplam Net',
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    user.totalNet.toStringAsFixed(2),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF6B6B),
                                    ),
                                  ),
                                  Text(
                                    'Puan',
                                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.white38),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastWeekWinner(FirestoreService firestoreService) {
    return FutureBuilder<UserProfile?>(
      future: firestoreService.getLastWeekWinner(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

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
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
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
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'ŞAMPİYON',
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Geçen Haftanın Şampiyonu',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      winner.displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Skor: ${winner.totalNet.toStringAsFixed(2)} Puan',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getRankColor(int index) {
    if (index == 0) return Colors.amber;
    if (index == 1) return Colors.blueGrey[300]!;
    if (index == 2) return Colors.brown[400]!;
    return const Color(0xFF3D5AF1);
  }
}
