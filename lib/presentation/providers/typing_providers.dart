import 'package:flutter/material.dart';
import 'package:typing_trainer/data/models/typing_stats.dart';
import 'package:typing_trainer/data/repositories/stats_repository.dart';

class TypingProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _currentText = '';
  String _userInput = '';
  int _currentIndex = 0;
  List<bool> _accuracy = [];
  List<TypingStats> _history = [];
  bool _isTyping = false;
  DateTime? _startTime;
  final StatsRepository _statsRepository;

  TypingProvider() : _statsRepository = StatsRepository() {
    _loadHistory();
  }

  // Getters
  ThemeMode get themeMode => _themeMode;
  String get currentText => _currentText;
  String get userInput => _userInput;
  int get currentIndex => _currentIndex;
  List<bool> get accuracy => _accuracy;
  List<TypingStats> get history => _history;
  bool get isTyping => _isTyping;
  DateTime? get startTime => _startTime;

  Future<void> _loadHistory() async {
    _history = await _statsRepository.loadHistory();
    notifyListeners();
  }

  // Toggle theme
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Start new typing session
  void startSession(String text) {
    _currentText = text;
    _userInput = '';
    _currentIndex = 0;
    _accuracy = List.filled(text.length, true);
    _isTyping = true;
    _startTime = DateTime.now();
    notifyListeners();
  }

  // Handle user input
  void handleInput(String input) {
    if (!_isTyping) return;

    if (input.length > _userInput.length) {
      final newChar = input.substring(input.length - 1);
      final expectedChar = _currentText[_currentIndex];
      _accuracy[_currentIndex] = (newChar == expectedChar);
      _currentIndex++;
    } else if (_currentIndex > 0) {
      _currentIndex--;
    }

    _userInput = input;
    notifyListeners();
  }

  // End session and save stats
  Future<void> endSession() async {
    if (!_isTyping || _startTime == null) return;

    final duration = DateTime.now().difference(_startTime!);
    final wpm = calculateWPM(duration);
    final accuracyPercent = calculateAccuracy();

    final newStat = TypingStats(
      date: DateTime.now(),
      wpm: wpm,
      accuracy: accuracyPercent,
    );

    _history.add(newStat);
    await _statsRepository.saveHistory(_history);

    _isTyping = false;
    notifyListeners();
  }

  double calculateWPM(Duration duration) {
    final minutes = duration.inSeconds / 60;
    final wordCount = _currentText.split(' ').length;
    return wordCount / minutes;
  }

  double calculateAccuracy() {
    final correctCount = _accuracy.where((a) => a).length;
    return (correctCount / _accuracy.length) * 100;
  }

  double get currentWpm {
    if (!_isTyping || _startTime == null) return 0;
    return calculateWPM(DateTime.now().difference(_startTime!));
  }

  double get currentAccuracy {
    if (!_isTyping) return 0;
    return calculateAccuracy();
  }
}
