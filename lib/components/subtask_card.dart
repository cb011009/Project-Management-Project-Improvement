import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/models/subtask.dart';



class SubtaskCard extends StatelessWidget {
  final Subtask subtask;
  final Project project;
  final Function onPressed;

  SubtaskCard({
    required this.subtask,
    required this.project,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 0, 107, 125), 
              width: 1.0, 
            ),
          ),
          
          child: ListTile(
            title: Text(
              '${subtask.name}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 10),
                Text(
                  'Due ${_formatDate(subtask.endDate)}',
                  style: TextStyle(fontSize: 12),
                ),
               
              ],
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime endDate) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final formattedDate = 'Due ${endDate.day} ${months[endDate.month - 1]} ${endDate.year}';

    return formattedDate;
  }
}



