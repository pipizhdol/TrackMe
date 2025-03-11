import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    );

    Navigator.pop(context, {
      'title': enteredTitle,
      'description': enteredDescription,
      'targetCount': enteredTargetCount,
      'reminderTime': _reminderTime,
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _reminderTime = pickedDate;
      });
    });
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
                  Text('Напоминание: ${_reminderTime.toLocal()}'),
                  TextButton(
                    onPressed: _presentDatePicker,
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Выбрать дату',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).textTheme.labelLarge?.color, // Исправлено на labelLarge
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