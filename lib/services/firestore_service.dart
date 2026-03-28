import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Helper to get week identifier (Starting Monday)
  String _getWeekId(DateTime date) {
    // Find the Monday of the current week
    int daysToMonday = date.weekday - DateTime.monday;
    DateTime monday = date.subtract(Duration(days: daysToMonday));
    return "${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}";
  }

  // Save or Update User Score
  Future<void> saveQuizResult(String uid, String displayName, double score) async {
    final userRef = _db.collection('users').doc(uid);
    final weekId = _getWeekId(DateTime.now());
    final weeklyRef = _db.collection('weekly_scores').doc('${uid}_$weekId');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return _db.runTransaction((transaction) async {
      // 1. Update Global Profile & Streak
      final userSnapshot = await transaction.get(userRef);
      if (!userSnapshot.exists) {
        transaction.set(userRef, {
          'displayName': displayName,
          'highScore': score,
          'totalGamesPlayed': 1,
          'currentStreak': 1,
          'longestStreak': 1,
          'lastActivityDate': Timestamp.fromDate(today),
        });
      } else {
        final data = userSnapshot.data()!;
        double currentHighScore = (data['highScore'] ?? 0).toDouble();
        double newHighScore = score > currentHighScore ? score : currentHighScore;
        int totalGames = (data['totalGamesPlayed'] ?? 0) + 1;
        
        // Streak Logic
        int currentStreak = data['currentStreak'] ?? 0;
        int longestStreak = data['longestStreak'] ?? 0;
        DateTime? lastActivity;
        if (data['lastActivityDate'] != null) {
          lastActivity = (data['lastActivityDate'] as Timestamp).toDate();
        }

        if (lastActivity != null) {
          final lastDate = DateTime(lastActivity.year, lastActivity.month, lastActivity.day);
          final difference = today.difference(lastDate).inDays;

          if (difference == 1) {
            // Consecutive day
            currentStreak += 1;
          } else if (difference > 1) {
            // Gap between days
            currentStreak = 1;
          } else if (difference == 0) {
            // Already played today, no streak change
          }
        } else {
          currentStreak = 1;
        }

        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }

        transaction.update(userRef, {
          'displayName': displayName,
          'highScore': newHighScore,
          'totalGamesPlayed': totalGames,
          'currentStreak': currentStreak,
          'longestStreak': longestStreak,
          'lastActivityDate': Timestamp.fromDate(today),
        });
      }


      // 2. Update Weekly High Score
      final weeklySnapshot = await transaction.get(weeklyRef);
      if (!weeklySnapshot.exists) {
        transaction.set(weeklyRef, {
          'uid': uid,
          'displayName': displayName,
          'weekId': weekId,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        double currentWeeklyScore = (weeklySnapshot.data()?['score'] ?? 0).toDouble();
        if (score > currentWeeklyScore) {
          transaction.update(weeklyRef, {
            'score': score,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }
    });
  }

  // Get Top Users for Global Leaderboard
  Stream<List<UserProfile>> getLeaderboard({int limit = 20}) {
    return _db
        .collection('users')
        .orderBy('highScore', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserProfile(
                  uid: doc.id,
                  displayName: doc.data()['displayName'] ?? 'Misafir',
                  highScore: (doc.data()['highScore'] ?? 0).toDouble(),
                  totalGamesPlayed: doc.data()['totalGamesPlayed'] ?? 0,
                ))
            .toList());
  }

  // Get Top Users for Weekly Leaderboard
  Stream<List<UserProfile>> getWeeklyLeaderboard({int limit = 20}) {
    final weekId = _getWeekId(DateTime.now());
    return _db
        .collection('weekly_scores')
        .where('weekId', isEqualTo: weekId)
        .orderBy('score', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserProfile(
                  uid: doc.data()['uid'],
                  displayName: doc.data()['displayName'] ?? 'Misafir',
                  highScore: (doc.data()['score'] ?? 0).toDouble(),
                  // totalGamesPlayed is not tracked weekly in this simple version, 
                  // but we could if needed. Setting to 0 for now.
                  totalGamesPlayed: 0, 
                ))
            .toList());
  }

  // Get Last Week's Winner
  Future<UserProfile?> getLastWeekWinner() async {
    final lastWeekId = _getWeekId(DateTime.now().subtract(const Duration(days: 7)));
    final snapshot = await _db
        .collection('weekly_scores')
        .where('weekId', isEqualTo: lastWeekId)
        .orderBy('score', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return UserProfile(
        uid: doc.data()['uid'],
        displayName: doc.data()['displayName'] ?? 'Misafir',
        highScore: (doc.data()['score'] ?? 0).toDouble(),
        totalGamesPlayed: 0,
      );
    }
  // Get Single User Profile
  Stream<UserProfile?> getUserProfile(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserProfile.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
}

