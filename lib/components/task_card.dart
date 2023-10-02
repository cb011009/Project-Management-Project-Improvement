import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/components/subtask_card.dart'; 
import 'package:pimp_project/models/task.dart';
import 'package:pimp_project/models/subtask.dart';
import 'package:pimp_project/screens/create_subtask_page.dart'; 


class TaskCard extends StatelessWidget {
  final Task task;
  final Project project;
  final Function(Subtask, Project) onPressed;

  TaskCard({required this.task, required this.project, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    '${task.priority}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                task.name,
                style: TextStyle(
                  fontSize: 23, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                '${_formatDate(task.startDate)} to ${_formatDate(task.endDate)}',
                style: TextStyle(fontSize: 13), 
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtasks',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add), 
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateSubtaskPage(project: project, task: task),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            for (var subtask in task.subtasks)
              SubtaskCard(
                subtask: subtask,
                project: project,
                onPressed: () {
                  onPressed(subtask, project);
                },
              ),
          ],
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final startMonth = months[date.month - 1];
    final formattedDate = '${date.day} $startMonth ${date.year}';

    return formattedDate;
  }
}


