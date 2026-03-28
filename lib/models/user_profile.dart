import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String displayName;
  final double highScore;
  final int totalGamesPlayed;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.highScore,
    required this.totalGamesPlayed,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActivityDate,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentId) {
    return UserProfile(
      uid: documentId,
      displayName: data['displayName'] ?? 'Misafir',
      highScore: (data['highScore'] ?? 0).toDouble(),
      totalGamesPlayed: data['totalGamesPlayed'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
      longestStreak: data['longestStreak'] ?? 0,
      lastActivityDate: data['lastActivityDate'] != null 
          ? (data['lastActivityDate'] as Timestamp).toDate() 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'highScore': highScore,
      'totalGamesPlayed': totalGamesPlayed,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivityDate': lastActivityDate != null 
          ? Timestamp.fromDate(lastActivityDate!) 
          : null,
    };
  }
}

