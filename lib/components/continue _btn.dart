import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding; 

  ContinueButton({
    required this.buttonText,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 1), 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white, 
          onPrimary: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.grey), 
          ),
          padding: padding, 
          elevation: 0, 
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Button Example'),
      ),
      body: Center(
        child: ContinueButton(
          buttonText: 'Continue',
          onPressed: () {
           
          },
        ),
      ),
    ),
  ));
}

