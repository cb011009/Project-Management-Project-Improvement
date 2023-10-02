import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/screens/create_subtask_daily_targets_page.dart'; 
import 'package:pimp_project/screens/create_task_page.dart'; 
import 'package:pimp_project/components/project_info_box.dart';
import 'package:pimp_project/components/add_btn.dart';
import 'package:pimp_project/components/task_card.dart';
import 'package:pimp_project/components/navigation.dart';




class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  ProjectDetailsPage({required this.project});
int _selectedIndex = 0;
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final startMonth = months[date.month - 1];
    final formattedDate = '${date.day} $startMonth ${date.year}';

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           
            ProjectInfoBox(
              project: project, 
              onBack: () {
               
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Text(
                    'Tasks:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0), 
                  for (var task in project.tasks)
                    TaskCard(
                      task: task,
                      project: project, 
                      onPressed: (subtask, project) {
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubtaskTargetPage(subtask: subtask, project: project),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomButton(
        buttonText: 'Task',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(project: project),
            ),
          );
        },
      ),
       bottomNavigationBar: CustomBottomNavigationBar(
  currentIndex: _selectedIndex,
  
    )
    );
  }
}


