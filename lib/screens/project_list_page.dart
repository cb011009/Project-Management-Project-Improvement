import 'package:flutter/material.dart';
import 'package:pimp_project/models/project.dart';
import 'package:pimp_project/screens/create_project_page.dart';
import 'package:pimp_project/screens/project_details_page.dart'; 
import 'package:pimp_project/components/navigation.dart';
import 'package:pimp_project/components/add_btn.dart';



class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Project> projects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80.0), 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PIPM',
                style: TextStyle(
                  fontSize: 15, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0), 
                child: Text(
                  'Projects', 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.all(16),
                     child: ListTile(
  title: Padding(
    padding: EdgeInsets.only(top: 10.0), 
    child: Text(
      project.name,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 18, 
      ),
    ),
  ),
  subtitle: Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 8.0),  
    child: Text(
      _formatDate(project.startDate, project.endDate),
      style: TextStyle(fontSize: 14), 
    ),
  ),
  onTap: () {
   
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailsPage(project: project),
      ),
    );
  },
),

                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        buttonText: 'Project',
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProjectPage(),
            ),
          );

          if (result is Project) {
            setState(() {
              projects.add(result);
            });
          }
        },
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
  currentIndex: _selectedIndex,
  
  
)

    );
  }

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
}


