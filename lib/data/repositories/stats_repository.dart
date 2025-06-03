import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:typing_trainer/data/models/typing_stats.dart';

class StatsRepository {
  static const _historyKey = 'typing_history';

  Future<List<TypingStats>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_historyKey);
    if (json != null) {
      try {
        final list = jsonDecode(json) as List;
        return list.map((e) => TypingStats.fromJson(e)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  Future<void> saveHistory(List<TypingStats> stats) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(stats.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, json);
  }
}
