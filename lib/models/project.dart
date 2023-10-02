


import 'task.dart';
class Project {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<Task> tasks;
  final List<String> assignees;
  

  Project({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.tasks,
    required this.assignees,
  });
}