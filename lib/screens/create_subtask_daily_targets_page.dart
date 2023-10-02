import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/models/task.dart';
import 'package:pimp_project/models/subtask.dart';
import 'package:pimp_project/screens/project_details_page.dart';
import 'package:pimp_project/models/checklist.dart';
import 'package:pimp_project/components/navigation.dart';


class SubtaskTargetPage extends StatefulWidget {
  final Subtask subtask;
  final Project project;

  SubtaskTargetPage({required this.subtask, required this.project});

  @override
  _SubtaskTargetPageState createState() => _SubtaskTargetPageState();

  
}

class _SubtaskTargetPageState extends State<SubtaskTargetPage> {
  int _selectedIndex = 0;
  TextEditingController _checklistItemController = TextEditingController();

  void _updateCompletionPercentage() {
    final checklist = widget.subtask.checklist;
    final totalItems = checklist.length;
    final completedItems = checklist.where((item) => item.isComplete).length;
    final completionPercentage =
        totalItems > 0 ? (completedItems / totalItems) * 100 : 0.0;

    setState(() {
      widget.subtask.completionPercentage = completionPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'PIPM',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              widget.subtask.name, 
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold, color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                
                Icon(
                  Icons.check_circle, 
                  color: widget.subtask.completionPercentage == 100
                      ? const Color.fromARGB(255, 76, 175, 157)
                      : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Completion: ${widget.subtask.completionPercentage.toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person, 
                ),
                SizedBox(width: 8),
                Text(
                  'Assignee: ${widget.subtask.assignee}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 16),
            for (var checklistItem in widget.subtask.checklist)
              Card(
                child: ListTile(
                  leading: Checkbox(
                    value: checklistItem.isComplete,
                    onChanged: (value) {
                      setState(() {
                        checklistItem.isComplete = value!;
                      });
                      _updateCompletionPercentage(); 
                    },
                  ),
                  title: Text(checklistItem.name),
                ),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _checklistItemController,
                    decoration: InputDecoration(
                      labelText: 'Add Checklist Item',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final newItemName = _checklistItemController.text;
                    if (newItemName.isNotEmpty) {
                      setState(() {
                        widget.subtask.checklist
                            .add(ChecklistItem(name: newItemName));
                        _checklistItemController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final checklist = widget.subtask.checklist;
                bool isComplete = checklist.isNotEmpty &&
                    checklist.every((item) => item.isComplete);

                widget.subtask.isComplete = isComplete;

                final task = widget.project.tasks
                    .firstWhere((t) => t.subtasks.contains(widget.subtask));
                task.subtasks[task.subtasks.indexOf(widget.subtask)] =
                    widget.subtask;
                

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProjectDetailsPage(project: widget.project),
                  ),
                );
              },
              child: Text('Finish'),
              
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
  currentIndex: _selectedIndex,
  
  
)
    );
  }
}

