import 'package:flutter/material.dart';
import 'package:pimp_project/routes/app_routes.dart';
import 'package:pimp_project/screens/project_list_page.dart';
import 'package:pimp_project/screens/create_project_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      
      initialRoute: AppRoutes.projectList, 
      routes: {
        AppRoutes.projectList: (context) => ProjectListPage(),
        AppRoutes.createProject: (context) => CreateProjectPage(),
       
      },
    );
  }
}


