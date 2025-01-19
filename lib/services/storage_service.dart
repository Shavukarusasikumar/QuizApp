import 'dart:convert';

import 'package:quiz_app/models/user_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _progressKey = 'user_progress';

  static Future<void> saveProgress(UserProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, json.encode(progress.toJson()));
  }

  static Future<UserProgress> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? progressJson = prefs.getString(_progressKey);
    if (progressJson != null) {
      return UserProgress.fromJson(json.decode(progressJson));
    }
    return UserProgress();
  }
}
