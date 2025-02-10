import 'package:flutter/material.dart';

// ---------------- General App Colors ----------------
const Color backgroundColor = Color(0xFFFCFCFC);
const Color hoverShadowColor = Colors.grey;

// ---------------- Title Styling ----------------
const double titleFontSize = 54.0;
const Color titleTextColor = Colors.black;
const double titleBorderRadius = 16.0;

const TextStyle titleTextStyle = TextStyle(
  color: titleTextColor,
  fontSize: titleFontSize,
);

const Color titleBackgroundColor = Colors.white;//Color(0xFFAC9E00);

// ---------------- Image Scale Factors ----------------
const double imageScaleFactor = 0.2;
const double topRightImageScaleFactor = 0.12;

// ---------------- Margins and Padding ----------------
const double backButtonTopMargin = 32.0;
const double topRightImageMargin = 32.0;
const EdgeInsets horizontalMargin = EdgeInsets.symmetric(horizontal: 16.0);

// ---------------- Shadow Opacities ----------------
const double hoverShadowOpacity = 0.8;
const double pressedShadowOpacity = 1.0;
const double defaultShadowOpacity = 0.4;

// ---------------- CustomButton Parameters ----------------

// Button Size in width portion
const double customButtonSize = 0.25;
const double imageIconSize = 0.4;

// Border Styling
const double customButtonBorderRadius = 12.0;
const double customButtonBorderWidth = 3.0;
const Color customButtonBorderColor = Color(0xFFAC9E00);
const Color showSelectionButtonBorderColor = Color(0xFF6D4C41);

// Background Color
const Color customButtonBackgroundColor = Colors.white;

// Shadow Parameters
const Color customButtonShadowColor = Colors.black12;
const double customButtonShadowBlurRadius = 4.0;
const Offset customButtonShadowOffset = Offset(2, 2);

// Icon Parameters
const EdgeInsets customButtonIconPadding = EdgeInsets.symmetric(vertical: 8.0);

// Text Styling for Button
const TextStyle customButtonTextStyle = TextStyle(
  fontSize: 54,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

// ---------------- Grid Parameters ----------------
const int gridCrossAxisCount = 4; // Number of items per row
const double gridCrossAxisSpacing = 20.0; // Horizontal spacing between items
const double gridMainAxisSpacing = 20.0; // Vertical spacing between items
const EdgeInsets gridPadding = EdgeInsets.all(20.0); // Padding around the grid

// ---------------- Show Selection Button Parameters ----------------
const String showSelectionIconPath = 'assets/show_selection_icon.png';
const String showSelectionButtonText = 'Show Selection';
const Color showSelectionButtonColor = Colors.white; // Brownish color

// ---------------- Generic Button Color Scheme ----------------
const Color selectedButtonBackgroundColor = Colors.redAccent; // Highlighted button
const Color defaultButtonBackgroundColor = customButtonBackgroundColor;
const Color selectedButtonBorderColor = Colors.redAccent; // Border for selected buttons

// ---------------- Icon Path Constants ----------------
// Industry Icons
const String mattressIconPath = 'assets/mattress.png';
const String upholsteryIconPath = 'assets/upholstery.png';
const String automotiveIconPath = 'assets/automotive.png';

// Category Icons
const String applicationIconPath = 'assets/application_icon.png';
const String formulationIconPath = 'assets/formulation_icon.png';
const String materialsIconPath = 'assets/materials_icon.png';
