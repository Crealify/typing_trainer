class UserStats {
  final int totalSessions;
  final int totalSentences;
  final double highestWpm;
  final double averageAccuracy;
  final int currentStreak;
  final DateTime lastPracticeDate;

  const UserStats({
    required this.totalSessions,
    required this.totalSentences,
    required this.highestWpm,
    required this.averageAccuracy,
    required this.currentStreak,
    required this.lastPracticeDate,
  });

  // Add toJson/fromJson methods similar to TypingSession
}