import 'package:flutter/material.dart';
import 'habit.dart';

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;
  final Function(String) onIncrement;
  final Function(String) onDelete;

  HabitDetailScreen({
    required this.habit,
    required this.onIncrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Описание: ${habit.description}'),
            Text('Прогресс: ${habit.currentCount}/${habit.targetCount}'),
            Text('Напоминание: ${habit.reminderTime.toLocal()}'),
            ElevatedButton(
              onPressed: () => onIncrement(habit.id),
              child: Text('Отметить выполнение'),
            ),
            ElevatedButton(
              onPressed: () {
                onDelete(habit.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Удалить привычку'),
            ),
          ],
        ),
      ),
    );
  }
}