class UserProgress {
  final int highScore;
  final int totalCoins;
  final int gamesPlayed;

  UserProgress({
    this.highScore = 0,
    this.totalCoins = 0,
    this.gamesPlayed = 0,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      highScore: json['highScore'] ?? 0,
      totalCoins: json['totalCoins'] ?? 0,
      gamesPlayed: json['gamesPlayed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highScore': highScore,
      'totalCoins': totalCoins,
      'gamesPlayed': gamesPlayed,
    };
  }

  UserProgress copyWith({
    int? highScore,
    int? totalCoins,
    int? gamesPlayed,
  }) {
    return UserProgress(
      highScore: highScore ?? this.highScore,
      totalCoins: totalCoins ?? this.totalCoins,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
    );
  }
}
