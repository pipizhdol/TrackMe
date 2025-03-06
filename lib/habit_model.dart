class Habit {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime date;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
  });
}