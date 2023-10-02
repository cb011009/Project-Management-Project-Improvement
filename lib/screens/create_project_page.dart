import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/components/continue _btn.dart';
import 'package:pimp_project/components/add_assignee_btn.dart';



class CreateProjectPage extends StatefulWidget {
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  DateTime? startDate;
  DateTime? endDate;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();

  List<String> assignees = [];
  List<bool> selectedUsers = [];
  Set<String> enteredEmails = Set();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedStartDate != null) {
      setState(() {
        startDate = pickedStartDate;
        startDateController.text = "${startDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedEndDate != null) {
      setState(() {
        endDate = pickedEndDate;
        endDateController.text = "${endDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  void _createProject() {
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both start and end dates.'),
        ),
      );
      return;
    }

    final projectName = projectNameController.text;
    final projectDescription = projectDescriptionController.text;

    final newProject = Project(
      name: projectName,
      description: projectDescription,
      startDate: startDate!,
      endDate: endDate!,
      assignees: assignees,
      tasks: [],
    );

    
    Navigator.pop(context, newProject);
  }

  void _deleteSelectedUsers() {
    List<String> filteredAssignees = [];
    List<bool> filteredSelectedUsers = [];

    for (int i = 0; i < assignees.length; i++) {
      if (!selectedUsers[i]) {
        filteredAssignees.add(assignees[i]);
        filteredSelectedUsers.add(false);
      }
    }

    setState(() {
      assignees = filteredAssignees;
      selectedUsers = filteredSelectedUsers;
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
            SizedBox(height: 20),
            Center(
  child: TextFormField(
    controller: projectNameController,
    decoration: InputDecoration(
      hintText: 'Project Name',
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

            SizedBox(height: 20),
            TextFormField(
              controller: projectDescriptionController,
              decoration: InputDecoration(labelText: 'Project Description'),
            ),
            SizedBox(height: 35),
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
            SizedBox(height: 35),
            Text(
              'Add Assignees:',
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
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'youremail@gmail.com',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                assigneeButton(
                  buttonText: '+',
                  onPressed: () {
                    final email = emailController.text;
                    if (email.isNotEmpty && !enteredEmails.contains(email)) {
                      assignees.add(email);
                      selectedUsers.add(false);
                      enteredEmails.add(email);
                      setState(() {});
                      emailController.clear();
                    }
                  },
                )
              ],
            ),
            if (assignees.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Assignees:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: assignees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: selectedUsers[index],
                      onChanged: (value) {
                        setState(() {
                          selectedUsers[index] = value!;
                        });
                      },
                    ),
                    title: Text(assignees[index]),
                  );
                },
              ),
              
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _deleteSelectedUsers();
                },
                icon: Icon(Icons.delete),
                label: Text('Delete Selected'),
              ),
            ],
            SizedBox(height: 35),
            Row(
              children: [
                Text(
                  'Add Attachment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.attach_file),
              ],
            ),
            SizedBox(height: 50),
            ContinueButton(
              buttonText: 'Create Project',
              
              onPressed: () {
                _createProject();
              },
            )
          ],
        ),
      ),
    );
  }
}


