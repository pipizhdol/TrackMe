import 'package:flutter/material.dart';
import 'add_habit.dart';
import 'habit_detail.dart';
import 'habit.dart';
import 'notification_service.dart';

class HabitListScreen extends StatefulWidget {
  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  List<Habit> _habits = [];

  void _addHabit(String title, String description, int targetCount, DateTime reminderTime) {
    final newHabit = Habit(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      targetCount: targetCount,
      reminderTime: reminderTime,
    );

    setState(() {
      _habits.add(newHabit);
    });
  }

  void _deleteHabit(String id) {
    final habit = _habits.firstWhere((habit) => habit.id == id);
    NotificationService().cancelNotification(habit.id.hashCode);
    setState(() {
      _habits.removeWhere((habit) => habit.id == id);
    });
  }

  void _incrementHabit(String id) {
    setState(() {
      final habit = _habits.firstWhere((habit) => habit.id == id);
      habit.currentCount++;
    });
  }

  void _navigateToAddHabit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddHabitScreen()),
    );

    if (result != null) {
      _addHabit(result['title'], result['description'], result['targetCount'], result['reminderTime']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TrackMe'),
      ),
      body: _habits.isEmpty
          ? Center(
              child: Text('Добавьте свою первую привычку!'),
            )
          : ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(_habits[index].title),
                  subtitle: Text('Прогресс: ${_habits[index].currentCount}/${_habits[index].targetCount}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitDetailScreen(
                          habit: _habits[index],
                          onIncrement: _incrementHabit,
                          onDelete: _deleteHabit,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddHabit(context),
        child: Icon(Icons.add),
      ),
    );
  }
}