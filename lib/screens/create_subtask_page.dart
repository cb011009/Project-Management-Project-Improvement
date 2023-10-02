import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart'; 
import 'package:pimp_project/models/task.dart'; 
import 'package:pimp_project/models/subtask.dart'; 
import 'package:pimp_project/screens/create_subtask_daily_targets_page.dart';
import 'package:pimp_project/components/continue _btn.dart'; 



class CreateSubtaskPage extends StatefulWidget {
  final Project project;
  final Task task;

  CreateSubtaskPage({required this.project, required this.task});

  @override
  _CreateSubtaskPageState createState() => _CreateSubtaskPageState();
}

class _CreateSubtaskPageState extends State<CreateSubtaskPage> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  
  List<String> assignees = [];

  
  String? selectedAssignee;

  @override
  void initState() {
    super.initState();
    
    assignees = widget.project.assignees;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedStartDate != null) {
      setState(() {
        _startDate = pickedStartDate;
        startDateController.text = "${_startDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedEndDate != null) {
      setState(() {
        _endDate = pickedEndDate;
        endDateController.text = "${_endDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
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
            SizedBox(height: 20),
            Center(
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Subtask Name',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(Icons.edit),
                  border: InputBorder.none,
                  prefix: SizedBox(width: 80.0),
                ),
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Choose a Start and End Date:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'MM/DD/YYYY',
                      suffixIcon: Icon(Icons.date_range),
                    ),
                    controller: startDateController,
                    onTap: () {
                      _selectStartDate(context);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      hintText: 'MM/DD/YYYY',
                      suffixIcon: Icon(Icons.date_range),
                    ),
                    controller: endDateController,
                    onTap: () {
                      _selectEndDate(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Select to assign subtask to:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: assignees.map((assignee) {
                return ListTile(
                  title: Text(assignee),
                  leading: Radio(
                    value: assignee,
                    groupValue: selectedAssignee,
                    onChanged: (String? value) {
                      setState(() {
                        selectedAssignee = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ContinueButton(
              buttonText: 'Continue',
              onPressed: () {
                final newSubtask = Subtask(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  startDate: _startDate!,
                  endDate: _endDate!,
                  assignee: selectedAssignee,
                  checklist: [],
                );

                widget.task.subtasks.add(newSubtask);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubtaskTargetPage(
                      subtask: newSubtask,
                      project: widget.project,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

