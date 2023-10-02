
import 'package:flutter/material.dart';
import 'package:pimp_project/components/description.dart';
import 'package:pimp_project/screens/assignnees.dart';
import 'package:pimp_project/models/project.dart'; 


class ProjectInfoBox extends StatelessWidget {
  final Project project;
  final VoidCallback onBack;

  ProjectInfoBox({
    required this.project,
    required this.onBack, 
  });

  String _formatDate(DateTime startDate, DateTime endDate) {
    final startFormatted =
        '${startDate.day} ${_getMonthAbbreviation(startDate.month)} ${startDate.year}';
    final endFormatted =
        '${endDate.day} ${_getMonthAbbreviation(endDate.month)} ${endDate.year}';
    return '$startFormatted to $endFormatted';
  }

  String _getMonthAbbreviation(int month) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 126, 191, 206),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  if (onBack != null) {
                    onBack();
                  }
                },
              ),
              Text(
                'PIPM',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Center(
  child: Text(
    '${project.name}',
    style: TextStyle(
      fontSize: 24,
      color: const Color.fromARGB(255, 0, 0, 0),
    ),
  ),
),
          SizedBox(height: 14.0),
          Text(
            '${_formatDate(project.startDate, project.endDate)}', 
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 20.0),
         
          DescriptionWidget(description: project.description),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
            
            IconButton(
  icon: Icon(Icons.person),
  onPressed: () {
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssigneesPage(
          assignees: project.assignees, 
          project: project, 
        ),
      ),
    );
  },
),

          
              Text(
                '${project.assignees.length} Assignee', 
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              SizedBox(width: 16.0), 
            
              IconButton(
                icon: Icon(Icons.attach_file),
                
                
                onPressed: () {
                
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
