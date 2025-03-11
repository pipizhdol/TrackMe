import 'package:flutter/material.dart';
import 'notification_service.dart';
import 'habit_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HabitListScreen(),
    );
  }
}