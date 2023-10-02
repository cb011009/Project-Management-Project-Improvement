import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/screens/create_subtask_page.dart'; 
import 'package:pimp_project/models/task.dart';
import 'package:pimp_project/models/subtask.dart'; 
import 'package:pimp_project/components/continue _btn.dart';


class CreateTaskPage extends StatefulWidget {
  final Project project;

  CreateTaskPage({required this.project});

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
 

  String _priority = 'Medium'; 
  DateTime? _startDate;
  DateTime? _endDate;

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
                  hintText: 'Task Name',
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
            SizedBox(height: 35),
            Text(
              'Priority Level:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _priority = 'Low';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _priority == 'Low' ? Color.fromARGB(255, 124, 201, 213) : Color.fromARGB(255, 116, 196, 192),
                  ),
                  child: Text('Low'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _priority = 'Medium';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _priority == 'Medium' ? Color.fromARGB(255, 124, 201, 213):Color.fromARGB(255, 116, 196, 192),
                  ),
                  child: Text('Medium'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _priority = 'High';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _priority == 'High' ? Color.fromARGB(255, 124, 201, 213) : Color.fromARGB(255, 116, 196, 192),
                  ),
                  child: Text('High'),
                ),
              ],
            ),
            SizedBox(height: 20),
           
             ContinueButton(
              buttonText: 'Continue',
              onPressed: () {
                final newTask = Task(
                  name: _nameController.text,
                  startDate: _startDate ?? DateTime.now(),
                  endDate: _endDate ?? DateTime.now(),
                  priority: _priority,
                  subtasks: [],
                );

                widget.project.tasks.add(newTask);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateSubtaskPage(
                      project: widget.project,
                      task: newTask,
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


 