import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Get User's Weekly Rank
  Future<int?> getUserWeeklyRank(String uid) async {
    try {
      final weekId = _getWeekId(DateTime.now());
      final snapshot = await _db
          .collection('weekly_scores')
          .where('weekId', isEqualTo: weekId)
          .orderBy('score', descending: true)
          .get();

      for (int i = 0; i < snapshot.docs.length; i++) {
        if (snapshot.docs[i].data()['uid'] == uid) {
          return i + 1; // 1-indexed rank
        }
      }
      return null; // User not found in weekly leaderboard
    } catch (e) {
      print('Error getting weekly rank: $e');
      return null;
    }
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

      // Update Firebase Auth profile
      await FirebaseAuth.instance.currentUser?.updateDisplayName(newDisplayName);

      // Update weekly_scores collection (current week)
      final weekId = _getWeekId(DateTime.now());
      final weeklyRef = _db.collection('weekly_scores').doc('${uid}_$weekId');
      final weeklyDoc = await weeklyRef.get();
      if (weeklyDoc.exists) {
        await weeklyRef.update({
          'displayName': newDisplayName,
        });
      }

      // Update weekly_duel_scores collection (current week)
      final duelWeeklyRef = _db.collection('weekly_duel_scores').doc('${uid}_$weekId');
      final duelWeeklyDoc = await duelWeeklyRef.get();
      if (duelWeeklyDoc.exists) {
        await duelWeeklyRef.update({
          'displayName': newDisplayName,
        });
      }

      return true;
    } catch (e) {
      print('Error updating display name: $e');
      return false;
    }
  }

  // ==================== DUEL MODE ====================

  /// Save Duel Result
  Future<void> saveDuelResult({
    required String uid,
    required String displayName,
    required int duelPoints,
    required bool won,
    required bool isDraw,
  }) async {
    try {
      final weekId = _getWeekId(DateTime.now());
      final duelWeeklyRef = _db.collection('weekly_duel_scores').doc('${uid}_$weekId');

      await _db.runTransaction((transaction) async {
        final snapshot = await transaction.get(duelWeeklyRef);
        
        if (!snapshot.exists) {
          transaction.set(duelWeeklyRef, {
            'uid': uid,
            'displayName': displayName,
            'weekId': weekId,
            'duelPoints': duelPoints,
            'wins': won ? 1 : 0,
            'losses': (!won && !isDraw) ? 1 : 0,
            'draws': isDraw ? 1 : 0,
            'totalDuels': 1,
            'timestamp': FieldValue.serverTimestamp(),
          });
        } else {
          final data = snapshot.data()!;
          transaction.update(duelWeeklyRef, {
            'displayName': displayName,
            'duelPoints': (data['duelPoints'] ?? 0) + duelPoints,
            'wins': (data['wins'] ?? 0) + (won ? 1 : 0),
            'losses': (data['losses'] ?? 0) + ((!won && !isDraw) ? 1 : 0),
            'draws': (data['draws'] ?? 0) + (isDraw ? 1 : 0),
            'totalDuels': (data['totalDuels'] ?? 0) + 1,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      });
    } catch (e) {
      print('Error saving duel result: $e');
      rethrow;
    }
  }

  /// Get Weekly Duel Leaderboard
  Stream<List<Map<String, dynamic>>> getWeeklyDuelLeaderboard({int limit = 100}) {
    final weekId = _getWeekId(DateTime.now());
    return _db
        .collection('weekly_duel_scores')
        .where('weekId', isEqualTo: weekId)
        .orderBy('duelPoints', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  'uid': doc.data()['uid'] as String,
                  'displayName': doc.data()['displayName'] ?? 'Misafir',
                  'duelPoints': doc.data()['duelPoints'] ?? 0,
                  'wins': doc.data()['wins'] ?? 0,
                  'losses': doc.data()['losses'] ?? 0,
                  'draws': doc.data()['draws'] ?? 0,
                  'totalDuels': doc.data()['totalDuels'] ?? 0,
                })
            .toList());
  }

  /// Get Last Week's Duel Winner
  Future<Map<String, dynamic>?> getLastWeekDuelWinner() async {
    final lastWeekId = _getWeekId(DateTime.now().subtract(const Duration(days: 7)));
    final snapshot = await _db
        .collection('weekly_duel_scores')
        .where('weekId', isEqualTo: lastWeekId)
        .orderBy('duelPoints', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return {
        'uid': doc.data()['uid'] as String,
        'displayName': doc.data()['displayName'] ?? 'Misafir',
        'duelPoints': doc.data()['duelPoints'] ?? 0,
        'wins': doc.data()['wins'] ?? 0,
        'losses': doc.data()['losses'] ?? 0,
        'totalDuels': doc.data()['totalDuels'] ?? 0,
      };
    }
    return null;
  }

  // Consume 1 Duel Ticket
  Future<bool> consumeDuelTicket(String uid) async {
    try {
      final userRef = _db.collection('users').doc(uid);
      
      return await _db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);
        
        if (!userSnapshot.exists) return false;

        final data = userSnapshot.data()!;
        int tickets = data['duelTickets'] ?? 3;
        Timestamp? lastResetTimestamp = data['lastDuelTicketResetDate'] as Timestamp?;
        
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        
        if (lastResetTimestamp != null) {
          DateTime lastResetDate = lastResetTimestamp.toDate();
          DateTime lastResetDay = DateTime(lastResetDate.year, lastResetDate.month, lastResetDate.day);
          
          if (today.isAfter(lastResetDay)) {
            tickets = 3; // Reset tickets daily
          }
        } else {
            // first time playing duel
            tickets = 3;
        }

        if (tickets <= 0) {
          return false; // No tickets left
        }

        transaction.update(userRef, {
          'duelTickets': tickets - 1,
          'lastDuelTicketResetDate': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        return true;
      });
    } catch (e) {
      print('Error consuming duel ticket: $e');
      return false;
    }
  }

  // Reward 3 Duel Tickets (after watching ad)
  Future<bool> rewardDuelTickets(String uid) async {
    try {
      final userRef = _db.collection('users').doc(uid);
      
      return await _db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);
        
        if (!userSnapshot.exists) return false;

        final data = userSnapshot.data()!;
        int tickets = data['duelTickets'] ?? 3;
        
        transaction.update(userRef, {
          'duelTickets': tickets + 3,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        return true;
      });
    } catch (e) {
      print('Error rewarding duel tickets: $e');
      return false;
    }
  }

  // ==================== ONLINE MATCHMAKING ====================

  Future<Map<String, dynamic>?> findOrWaitMatch({
    required String uid,
    required String displayName,
    required String examType,
    required List<Map<String, dynamic>> questions,
  }) async {
    try {
      // 1. Try to find an existing waiting public room
      final querySnapshot = await _db
          .collection('duel_rooms')
          .where('status', isEqualTo: 'waiting')
          .where('isPrivate', isEqualTo: false)
          .where('examType', isEqualTo: examType)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Found a room, try to join
        final roomDoc = querySnapshot.docs.first;
        if (roomDoc.data()['player1Id'] == uid) {
             // It's our own room (shouldn't happen usually but just in case), delete it and create new or just return null to wait
             return null;
        }

        await roomDoc.reference.update({
          'player2Id': uid,
          'player2Name': displayName,
          'status': 'playing',
        });
        
        final updatedDoc = await roomDoc.reference.get();
        final data = updatedDoc.data();
        if (data != null) data['roomId'] = updatedDoc.id;
        return data;
      }

      // 2. Create a new room and wait
      final newRoomRef = await _db.collection('duel_rooms').add({
        'player1Id': uid,
        'player1Name': displayName,
        'player1Score': 0,
        'player1Correct': 0,
        'player2Id': null,
        'player2Name': null,
        'player2Score': 0,
        'player2Correct': 0,
        'status': 'waiting',
        'isPrivate': false,
        'examType': examType,
        'questions': questions,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final newRoomDoc = await newRoomRef.get();
      final data = newRoomDoc.data();
      if (data != null) data['roomId'] = newRoomDoc.id;
      return data;
    } catch (e) {
      print('Error in matchmaking: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createPrivateRoom({
    required String uid,
    required String displayName,
    required String examType,
    required String roomCode,
    required List<Map<String, dynamic>> questions,
  }) async {
    try {
      final roomRef = _db.collection('duel_rooms').doc(roomCode);
      await roomRef.set({
        'player1Id': uid,
        'player1Name': displayName,
        'player1Score': 0,
        'player1Correct': 0,
        'player2Id': null,
        'player2Name': null,
        'player2Score': 0,
        'player2Correct': 0,
        'status': 'waiting',
        'isPrivate': true,
        'examType': examType,
        'questions': questions,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final roomDoc = await roomRef.get();
      final data = roomDoc.data();
      if (data != null) data['roomId'] = roomDoc.id;
      return data;
    } catch (e) {
      print('Error creating private room: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> joinPrivateRoom({
    required String roomCode,
    required String uid,
    required String displayName,
  }) async {
    try {
      final roomRef = _db.collection('duel_rooms').doc(roomCode);
      final roomDoc = await roomRef.get();

      if (!roomDoc.exists) {
        return {'error': 'Oda bulunamadı'};
      }

      final data = roomDoc.data()!;
      if (data['status'] != 'waiting') {
        return {'error': 'Oyun zaten başlamış'};
      }

      if (data['player1Id'] == uid) {
         data['roomId'] = roomDoc.id;
         return data;
      }

      await roomRef.update({
        'player2Id': uid,
        'player2Name': displayName,
        'status': 'playing',
      });

      final updatedDoc = await roomRef.get();
      final updatedData = updatedDoc.data();
      if (updatedData != null) updatedData['roomId'] = updatedDoc.id;
      return updatedData;
    } catch (e) {
      print('Error joining private room: $e');
      return {'error': 'Odaya katılırken bir hata oluştu'};
    }
  }

  Stream<DocumentSnapshot> listenToRoom(String roomId) {
    return _db.collection('duel_rooms').doc(roomId).snapshots();
  }

  Future<void> updateRoomScore({
    required String roomId,
    required String playerKey,
    required int score,
    required int correct,
    int? answerIndex,
  }) async {
    try {
      await _db.collection('duel_rooms').doc(roomId).update({
        '${playerKey}Score': score,
        '${playerKey}Correct': correct,
        '${playerKey}AnswerIndex': answerIndex,
      });
    } catch (e) {
      print('Error updating room score: $e');
    }
  }

  Future<void> updateRoomEmoji(String roomId, String playerKey, String emojiData) async {
    try {
      await _db.collection('duel_rooms').doc(roomId).update({
        '${playerKey}Emoji': emojiData,
      });
    } catch (e) {
      print('Error updating emoji: $e');
    }
  }

  Future<void> requestRematch(String roomId, String newRoomId, String playerKey) async {
    try {
      await _db.collection('duel_rooms').doc(roomId).update({
        'rematchRoomId': newRoomId,
        'rematchRequestedBy': playerKey,
      });
    } catch (e) {
      print('Error requesting rematch: $e');
    }
  }

  Future<void> deleteRoom(String roomId) async {
    try {
      await _db.collection('duel_rooms').doc(roomId).delete();
    } catch (e) {
      print('Error deleting room: $e');
    }
  }

  // ==================== DUEL INVITES ====================

  Future<String?> sendDuelInvite({
    required String fromUid,
    required String fromName,
    required String toUid,
    required String roomCode,
  }) async {
    try {
      // Spam protection: check if there is an existing pending invite from this user to this user in the last 2 minutes
      final now = DateTime.now();
      final twoMinsAgo = now.subtract(const Duration(minutes: 2));

      final existingQuery = await _db
          .collection('duel_invites')
          .where('fromUid', isEqualTo: fromUid)
          .where('toUid', isEqualTo: toUid)
          .where('status', isEqualTo: 'pending')
          .get();

      if (existingQuery.docs.isNotEmpty) {
        for (var doc in existingQuery.docs) {
          final timestamp = doc.data()['createdAt'] as Timestamp?;
          if (timestamp != null && timestamp.toDate().isAfter(twoMinsAgo)) {
            return 'Lütfen tekrar istek atmak için biraz bekleyin.';
          }
        }
      }

      await _db.collection('duel_invites').add({
        'fromUid': fromUid,
        'fromName': fromName,
        'toUid': toUid,
        'roomCode': roomCode,
        'status': 'pending', // pending, accepted, rejected
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // Success
    } catch (e) {
      print('Error sending duel invite: $e');
      return 'İstek gönderilemedi.';
    }
  }

  Stream<QuerySnapshot> listenToIncomingInvites(String myUid) {
    return _db
        .collection('duel_invites')
        .where('toUid', isEqualTo: myUid)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future<void> updateInviteStatus(String inviteId, String status) async {
    try {
      await _db.collection('duel_invites').doc(inviteId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating invite status: $e');
    }
  }
}
