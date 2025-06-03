class TypingSession {
  final DateTime date;
  final String text;
  final double wpm;
  final double accuracy;
  final Duration duration;
  final int errors;
  final int correctChars;

  const TypingSession({
    required this.date,
    required this.text,
    required this.wpm,
    required this.accuracy,
    required this.duration,
    required this.errors,
    required this.correctChars,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'text': text,
        'wpm': wpm,
        'accuracy': accuracy,
        'duration': duration.inMilliseconds,
        'errors': errors,
        'correctChars': correctChars,
      };

  factory TypingSession.fromJson(Map<String, dynamic> json) => TypingSession(
        date: DateTime.parse(json['date']),
        text: json['text'],
        wpm: json['wpm'].toDouble(),
        accuracy: json['accuracy'].toDouble(),
        duration: Duration(milliseconds: json['duration']),
        errors: json['errors'],
        correctChars: json['correctChars'],
      );
}
