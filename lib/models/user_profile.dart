class UserProfile {
  final String uid;
  final String displayName;
  final double highScore;
  final int totalGamesPlayed;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.highScore,
    required this.totalGamesPlayed,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentId) {
    return UserProfile(
      uid: documentId,
      displayName: data['displayName'] ?? 'Misafir',
      highScore: (data['highScore'] ?? 0).toDouble(),
      totalGamesPlayed: data['totalGamesPlayed'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'highScore': highScore,
      'totalGamesPlayed': totalGamesPlayed,
    };
  }
}
