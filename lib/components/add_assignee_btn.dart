import 'package:flutter/material.dart';
import 'package:pimp_project/screens/create_project_page.dart';


class assigneeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  assigneeButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 55, 196, 201),
        onPrimary: const Color.fromARGB(255, 255, 255, 255),
        shape: CircleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}