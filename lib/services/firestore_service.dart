import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import 'notification_service.dart';

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
    try {
      final userRef = _db.collection('users').doc(uid);
      final weekId = _getWeekId(DateTime.now());
      final weeklyRef = _db.collection('weekly_scores').doc('${uid}_$weekId');
      
      int finalStreak = 1;
      
      await _db.runTransaction((transaction) async {
        // 1. Update Global High Score
        final userSnapshot = await transaction.get(userRef);
        if (!userSnapshot.exists) {
          transaction.set(userRef, {
            'displayName': displayName,
            'highScore': score,
            'totalNet': score,
            'totalGamesPlayed': 1,
            'currentStreak': 1,
            'lastQuizDate': FieldValue.serverTimestamp(),
            'lastUpdated': FieldValue.serverTimestamp(),
          });
        } else {
          double currentHighScore = (userSnapshot.data()?['highScore'] ?? 0).toDouble();
          double currentTotalNet = (userSnapshot.data()?['totalNet'] ?? currentHighScore).toDouble();
          double newHighScore = score > currentHighScore ? score : currentHighScore;
          double newTotalNet = currentTotalNet + score;
          int totalGames = (userSnapshot.data()?['totalGamesPlayed'] ?? 0) + 1;

          int currentStreak = userSnapshot.data()?['currentStreak'] ?? 0;
          Timestamp? lastQuizTimestamp = userSnapshot.data()?['lastQuizDate'] as Timestamp?;
          
          DateTime now = DateTime.now().toUtc();
          DateTime today = DateTime.utc(now.year, now.month, now.day);
          
          if (lastQuizTimestamp != null) {
            DateTime lastDate = lastQuizTimestamp.toDate().toUtc();
            DateTime lastDay = DateTime.utc(lastDate.year, lastDate.month, lastDate.day);
            
            final difference = today.difference(lastDay).inDays;
            
            if (difference == 1) {
              currentStreak += 1;
            } else if (difference > 1) {
              currentStreak = 1;
            }
          } else {
             currentStreak = 1;
          }
          finalStreak = currentStreak;

          transaction.update(userRef, {
            'displayName': displayName,
            'highScore': newHighScore,
            'totalNet': newTotalNet,
            'totalGamesPlayed': totalGames,
            'currentStreak': currentStreak,
            'lastQuizDate': FieldValue.serverTimestamp(),
            'lastUpdated': FieldValue.serverTimestamp(),
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
          // Always update displayName to sync with potential name changes/logins
          Map<String, dynamic> updateData = {
            'displayName': displayName,
            'uid': uid, // Ensure UID is always there
            'score': currentWeeklyScore + score,
            'timestamp': FieldValue.serverTimestamp(),
          };
          
          transaction.update(weeklyRef, updateData);
        }
      });
      
      // Schedule the next reminder with the calculated streak
      await NotificationService().scheduleStreakReminder(finalStreak);
      
    } catch (e) {
      print('Error saving quiz result: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Get Top Users for Global Leaderboard
  Stream<List<UserProfile>> getLeaderboard({int limit = 100}) {
    return _db
        .collection('users')
        .orderBy('totalNet', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserProfile(
                  uid: doc.id,
                  displayName: doc.data()['displayName'] ?? 'Misafir-${(doc.id.length >= 5) ? doc.id.substring(0, 5) : doc.id}',
                  highScore: (doc.data()['highScore'] ?? 0).toDouble(),
                  totalNet: (doc.data()['totalNet'] ?? (doc.data()['highScore'] ?? 0)).toDouble(),
                  totalGamesPlayed: doc.data()['totalGamesPlayed'] ?? 0,
                ))
            .toList());
  }

  // Get Top Users for Weekly Leaderboard
  Stream<List<UserProfile>> getWeeklyLeaderboard({int limit = 100}) {
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
                  displayName: doc.data()['displayName'] ?? 'Misafir-${(doc.data()['uid'].toString().length >= 5) ? doc.data()['uid'].toString().substring(0, 5) : doc.data()['uid']}',
                  highScore: 0, // Not relevant for weekly summary display
                  totalNet: (doc.data()['score'] ?? 0).toDouble(),
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
        displayName: doc.data()['displayName'] ?? 'Misafir-${(doc.data()['uid'].toString().length >= 5) ? doc.data()['uid'].toString().substring(0, 5) : doc.data()['uid']}',
        totalNet: (doc.data()['score'] ?? 0).toDouble(),
        highScore: 0,
        totalGamesPlayed: 0,
      );
    }
    return null;
  }

  // Get User Profile
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromMap(doc.data()!, doc.id);
      }
    } catch (e) {
      print('Error getting user profile: $e');
    }
    return null;
  }

  // Claim Rewarded Ad Bonus (+10 Points) with Daily Limit (Max 3)
  Future<bool> claimRewardedAdBonus(String uid, String displayName) async {
    try {
      final userRef = _db.collection('users').doc(uid);
      
      return await _db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);
        
        if (!userSnapshot.exists) return false;

        final data = userSnapshot.data()!;
        int watchedToday = data['rewardedAdsWatchedToday'] ?? 0;
        Timestamp? lastAdTimestamp = data['lastRewardedAdDate'] as Timestamp?;
        
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        
        // Reset count if last ad was not today
        if (lastAdTimestamp != null) {
          DateTime lastAdDate = lastAdTimestamp.toDate();
          DateTime lastAdDay = DateTime(lastAdDate.year, lastAdDate.month, lastAdDate.day);
          
          if (today.isAfter(lastAdDay)) {
            watchedToday = 0;
          }
        }

        // Check Limit
        if (watchedToday >= 3) {
          return false; // Limit reached
        }

        // Update Score and Limit
        double currentTotalNet = (data['totalNet'] ?? (data['highScore'] ?? 0)).toDouble();
        
        transaction.update(userRef, {
          'totalNet': currentTotalNet + 10,
          'rewardedAdsWatchedToday': watchedToday + 1,
          'lastRewardedAdDate': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Also update weekly score if needed
        final weekId = _getWeekId(now);
        final weeklyRef = _db.collection('weekly_scores').doc('${uid}_$weekId');
        
        final weeklySnapshot = await transaction.get(weeklyRef);
        if (weeklySnapshot.exists) {
          double currentWeeklyScore = (weeklySnapshot.data()?['score'] ?? 0).toDouble();
          transaction.update(weeklyRef, {
            'score': currentWeeklyScore + 10,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }

        return true;
      });
    } catch (e) {
      print('Error claiming reward bonus: $e');
      return false;
    }
  }

  // Update Display Name (Takma Ad)
  Future<bool> updateDisplayName(String uid, String newDisplayName) async {
    try {
      final userRef = _db.collection('users').doc(uid);
      
      // Update users collection
      await userRef.update({
        'displayName': newDisplayName,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // Update weekly_scores collection (current week)
      final weekId = _getWeekId(DateTime.now());
      final weeklyRef = _db.collection('weekly_scores').doc('${uid}_$weekId');
      final weeklyDoc = await weeklyRef.get();
      if (weeklyDoc.exists) {
        await weeklyRef.update({
          'displayName': newDisplayName,
        });
      }

      return true;
    } catch (e) {
      print('Error updating display name: $e');
      return false;
    }
  }
}
