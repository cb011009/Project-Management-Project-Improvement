import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;

  CustomButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, 
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 12.0, 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: Color.fromARGB(255, 8, 120, 152),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 49.0,
              height: 56.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 11, 167, 162),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
