import 'package:flutter/material.dart';
import '../constants.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0), // Small padding
      decoration: BoxDecoration(
        //color: titleBackgroundColor, // Background color from constants.dart
        borderRadius: BorderRadius.circular(customButtonBorderRadius), // Border radius
      ),
      child: Text(
        title,
        style: titleTextStyle, // Use centralized text style
        textAlign: TextAlign.center,
      ),
    );
  }
}
