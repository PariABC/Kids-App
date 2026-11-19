import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String? selectedClass; // Nursery, LKG, UKG
  Map<String, int> progress = {};

  Future<void> setClass(String className) async {
    selectedClass = className;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_class', className);
    notifyListeners();
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    selectedClass = prefs.getString('selected_class');
    notifyListeners();
  }

  void updateProgress(String lessonId, int stars) {
    progress[lessonId] = stars;
    notifyListeners();
  }

  int getStars(String lessonId) {
    return progress[lessonId] ?? 0;
  }
}
