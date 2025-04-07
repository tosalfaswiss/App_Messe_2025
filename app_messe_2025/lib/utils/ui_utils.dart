import 'package:flutter/material.dart';

EdgeInsets getHorizontalMargin(BuildContext context) {
  return EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02);
}

double getBorderRadius(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.02;
}

double getGridSpacing(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.015;
}

double getTitleFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.035; // 3.5% of width
}

TextStyle getTitleTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: getTitleFontSize(context),
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
