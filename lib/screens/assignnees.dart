import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';

import 'package:pimp_project/components/project_info_box.dart'; 
import 'package:pimp_project/components/add_btn.dart';
import 'package:pimp_project/components/navigation.dart';


class AssigneesPage extends StatefulWidget {
  final List<String> assignees;
  final Project project;

  AssigneesPage({
    required this.assignees,
    required this.project,
  });

  @override
  _AssigneesPageState createState() => _AssigneesPageState();
}

class _AssigneesPageState extends State<AssigneesPage> {
  TextEditingController _newAssigneeController = TextEditingController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ProjectInfoBox(
            project: widget.project,
            onBack: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Assignees:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: widget.assignees.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String assignee = entry.value;
                          return ListTile(
                            title: Text(assignee),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.assignees.removeAt(index);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomButton(
        buttonText: 'Assignee', 
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Assignee'),
                content: TextField(
                  controller: _newAssigneeController,
                  decoration: InputDecoration(labelText: 'Assignee Name'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      final newAssignee = _newAssigneeController.text;
                      if (newAssignee.isNotEmpty) {
                        setState(() {
                          widget.assignees.add(newAssignee);
                        });
                        _newAssigneeController.clear();
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
       bottomNavigationBar: CustomBottomNavigationBar(
  currentIndex: _selectedIndex,
  
    ),
    );
  }
}
