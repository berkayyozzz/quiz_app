import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String displayName;
  final double highScore;
  final double totalNet;
  final int totalGamesPlayed;
  final int currentStreak;
  final DateTime? lastQuizDate;
  final int rewardedAdsWatchedToday;
  final DateTime? lastRewardedAdDate;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.highScore,
    required this.totalNet,
    required this.totalGamesPlayed,
    this.currentStreak = 0,
    this.lastQuizDate,
    this.rewardedAdsWatchedToday = 0,
    this.lastRewardedAdDate,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentId) {
    return UserProfile(
      uid: documentId,
      displayName: data['displayName'] ?? 'Misafir-${(documentId.length >= 5) ? documentId.substring(0, 5) : documentId}',
      highScore: (data['highScore'] ?? 0).toDouble(),
      totalNet: (data['totalNet'] ?? (data['highScore'] ?? 0)).toDouble(),
      totalGamesPlayed: data['totalGamesPlayed'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
      lastQuizDate: data['lastQuizDate'] != null ? (data['lastQuizDate'] as Timestamp).toDate() : null,
      rewardedAdsWatchedToday: data['rewardedAdsWatchedToday'] ?? 0,
      lastRewardedAdDate: data['lastRewardedAdDate'] != null ? (data['lastRewardedAdDate'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'highScore': highScore,
      'totalNet': totalNet,
      'totalGamesPlayed': totalGamesPlayed,
      'currentStreak': currentStreak,
      'lastQuizDate': lastQuizDate != null ? Timestamp.fromDate(lastQuizDate!) : null,
      'rewardedAdsWatchedToday': rewardedAdsWatchedToday,
      'lastRewardedAdDate': lastRewardedAdDate != null ? Timestamp.fromDate(lastRewardedAdDate!) : null,
    };
  }
}
