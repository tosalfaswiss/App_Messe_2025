import 'package:flutter/material.dart';
import '../constants.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(customButtonBorderRadius),
      ),
      child: Text(
        title,
        style: titleTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
