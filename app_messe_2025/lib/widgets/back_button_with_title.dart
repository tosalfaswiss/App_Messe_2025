import 'package:flutter/material.dart';
import '../constants.dart';

class BackButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BackButtonWithTitle({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: titleTextColor),
          onPressed: onPressed,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
        ),
      ],
    );
  }
}
