import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'habit_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final completedHabits =
        habitProvider.habits.where((habit) => habit.isCompleted).length;
    final totalHabits = habitProvider.habits.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Прогресс'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Выполнено привычек: $completedHabits из $totalHabits',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              value: totalHabits > 0 ? completedHabits / totalHabits : 0,
              semanticsLabel: 'Прогресс',
            ),
          ],
        ),
      ),
    );
  }
}