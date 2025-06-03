class TypingStats {
  final DateTime date;
  final double wpm;
  final double accuracy;

  TypingStats({
    required this.date,
    required this.wpm,
    required this.accuracy,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'wpm': wpm,
    'accuracy': accuracy,
  };

  factory TypingStats.fromJson(Map<String, dynamic> json) => TypingStats(
    date: DateTime.parse(json['date']),
    wpm: json['wpm'].toDouble(),
    accuracy: json['accuracy'].toDouble(),
  );
}