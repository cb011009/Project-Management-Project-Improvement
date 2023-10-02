import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  final String description;

  DescriptionWidget({required this.description});

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final truncatedDescription = widget.description.length > 100
        ? widget.description.substring(0, 100)
        : widget.description;

    return Column(
      children: <Widget>[
        Text(
          isExpanded ? widget.description : truncatedDescription,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        if (widget.description.length > 100)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Show Less' : 'Show More',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
      ],
    );
  }
}
