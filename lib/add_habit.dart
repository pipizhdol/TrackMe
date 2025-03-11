import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования времени
import 'notification_service.dart';

class AddHabitScreen extends StatefulWidget {
  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetCountController = TextEditingController();
  DateTime _reminderTime = DateTime.now();
  String _repeatMode = 'Никогда'; // По умолчанию

  // Варианты повторов
  final List<String> _repeatOptions = [
    'Никогда',
    'Каждый день',
    'По будням',
    'По выходным',
  ];

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    final enteredTargetCount = int.tryParse(_targetCountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredDescription.isEmpty || enteredTargetCount <= 0) {
      return;
    }

    // Schedule notification
    NotificationService().scheduleNotification(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID
      enteredTitle,
      'Не забудьте выполнить: $enteredDescription',
      _reminderTime,
      _repeatMode, // Передаём режим повтора
    );

    Navigator.pop(context, {
      'title': enteredTitle,
      'description': enteredDescription,
      'targetCount': enteredTargetCount,
      'reminderTime': _reminderTime,
      'repeatMode': _repeatMode,
    });
  }

  // Выбор времени
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_reminderTime),
    );

    if (pickedTime != null) {
      setState(() {
        _reminderTime = DateTime(
          _reminderTime.year,
          _reminderTime.month,
          _reminderTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить привычку'),
      ),
      body: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Название'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Описание'),
                controller: _descriptionController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Цель (количество раз)'),
                controller: _targetCountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: <Widget>[
                  Text('Напоминание: ${DateFormat('HH:mm').format(_reminderTime)}'),
                  TextButton(
                    onPressed: _selectTime,
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Выбрать время',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                value: _repeatMode,
                onChanged: (String? newValue) {
                  setState(() {
                    _repeatMode = newValue!;
                  });
                },
                items: _repeatOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).textTheme.labelLarge?.color,
                ),
                child: Text('Добавить привычку'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}