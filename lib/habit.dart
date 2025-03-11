class Habit {
  String id;
  String title;
  String description;
  int targetCount;
  int currentCount;
  DateTime reminderTime;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.targetCount,
    this.currentCount = 0,
    required this.reminderTime,
  });
}