


import 'subtask.dart';
class Task {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String priority;
  final List<Subtask> subtasks;

  Task({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.subtasks,
  });
}

