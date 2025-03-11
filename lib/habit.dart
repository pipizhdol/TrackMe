class Habit {
  String id;
  String title;
  String description;
  int targetCount;
  int currentCount;
  DateTime reminderTime;
  String repeatMode; // Новое поле

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.targetCount,
    this.currentCount = 0,
    required this.reminderTime,
    required this.repeatMode, // Новое поле
  });
}