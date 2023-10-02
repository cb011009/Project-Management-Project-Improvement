
import 'package:flutter/material.dart';
import 'checklist.dart';

class Subtask {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  List<ChecklistItem> checklist; 
  bool isComplete;
  double completionPercentage; 
   String? assignee; 

  Subtask({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.checklist = const [], 
    this.isComplete = false, 
    this.completionPercentage = 0.0, 
    this.assignee, 
  });
}
