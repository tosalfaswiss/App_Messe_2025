import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFFFCFCFC);
const Color hoverShadowColor = Colors.grey;

const double titleFontSize = 54.0;
const Color titleTextColor = Colors.black;
const double titleBorderRadius = 16.0;

const TextStyle titleTextStyle = TextStyle(
  color: titleTextColor,
  fontSize: titleFontSize,
);

const Color titleBackgroundColor = Colors.white;

const double imageScaleFactor = 0.2;
const double topRightImageScaleFactor = 0.12;

double getTitleFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.05;
}

double getImageScaleFactor(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.15;
}

double getTopRightImageScaleFactor(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.1;
}

const double backButtonTopMargin = 32.0;
const double topRightImageMargin = 32.0;
const EdgeInsets horizontalMargin = EdgeInsets.symmetric(horizontal: 16.0);

const double hoverShadowOpacity = 0.8;
const double pressedShadowOpacity = 1.0;
const double defaultShadowOpacity = 0.4;

const double customButtonSize = 0.25;
const double imageIconSize = 0.4;

double getButtonSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.2;
}

const double customButtonBorderRadius = 12.0;
const double customButtonBorderWidth = 3.0;
const Color customButtonBorderColor = Color(0xFFAC9E00);
const Color showSelectionButtonBorderColor = Color(0xFF6D4C41);

const Color customButtonBackgroundColor = Colors.white;

const Color customButtonShadowColor = Colors.black12;
const double customButtonShadowBlurRadius = 4.0;
const Offset customButtonShadowOffset = Offset(2, 2);

const EdgeInsets customButtonIconPadding = EdgeInsets.symmetric(vertical: 8.0);

const TextStyle customButtonTextStyle = TextStyle(
  fontSize: 54,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const int gridCrossAxisCount = 4;
const double gridCrossAxisSpacing = 20.0;
const double gridMainAxisSpacing = 20.0;
const EdgeInsets gridPadding = EdgeInsets.all(20.0);

const String showSelectionIconPath = 'assets/show_selection_icon.png';
const String showSelectionButtonText = 'Show Selection';
const Color showSelectionButtonColor = Colors.white;

const Color selectedButtonBackgroundColor = Colors.redAccent;
const Color defaultButtonBackgroundColor = customButtonBackgroundColor;
const Color selectedButtonBorderColor = Colors.redAccent;

const String mattressIconPath = 'assets/mattress.png';
const String upholsteryIconPath = 'assets/upholstery.png';
const String automotiveIconPath = 'assets/automotive.png';
const String industrialIconPath = 'assets/industrial.png';

const String applicationIconPath = 'assets/application_icon.png';
const String formulationIconPath = 'assets/formulation_icon.png';
const String materialsIconPath = 'assets/materials_icon.png';

const String alfaLogoAsset = 'assets/alfa_klebstoffe.png';

// Slide Titles
const industrySlideTitle = "Which industry are you working in?";
const adhesiveTypeSlideTitle = "What type of adhesive are you looking for?";
const categorySelectionSlideTitle = "What product category best fits your needs?";
const resultsSlideTitle = "These products match your selection";
const selectCategoryTitlePrefix = "What is your desired ";

const List<String> adhesiveTypeOrder = [
  'Water-based Adhesives',
  'Hotmelt Adhesives',
  'Coatings',
];

const String topRightButtonIconPath = 'assets/simalfa.png';
const String deselectIconPath = 'assets/deselect_icon.png';
