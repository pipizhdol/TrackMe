import 'package:flutter/material.dart';
import 'habit_model.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  void addHabit(String title, String description, DateTime date) {
    final newHabit = Habit(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      date: date,
    );
    _habits.add(newHabit);
    notifyListeners();
  }

  void toggleHabitCompletion(String id) {
    final habitIndex = _habits.indexWhere((habit) => habit.id == id);
    if (habitIndex >= 0) {
      _habits[habitIndex].isCompleted = !_habits[habitIndex].isCompleted;
      notifyListeners();
    }
  }

  void deleteHabit(String id) {
    _habits.removeWhere((habit) => habit.id == id);
    notifyListeners();
  }
}