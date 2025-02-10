import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/title_widget.dart';
import '../widgets/back_button_with_title.dart';
import '../widgets/top_icons_button.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import 'category_detail_slide.dart';
import '../widgets/middle_grid.dart';
import '../utils/utils.dart';

class BaseSlide extends StatelessWidget {
  final String title;
  final Widget? topRightButton;
  final List<Map<String, dynamic>>? customButtonData;
  final void Function(String label)? onItemTap;
  final List<Map<String, dynamic>>? topIcons;
  final bool disableBackButton;
  final Filters filters;
  final AdhesiveService adhesiveService;
  final void Function() onBackPressed;
  final int gridColumns;

  const BaseSlide({
    Key? key,
    required this.title,
    this.topRightButton,
    this.customButtonData,
    this.onItemTap,
    this.topIcons,
    this.disableBackButton = false,
    required this.filters,
    required this.adhesiveService,
    required this.onBackPressed,
    this.gridColumns = 4,
  })   : assert(
          disableBackButton || onBackPressed != defaultOnBackPressed,
          "onBackPressed must be provided if disableBackButton is false",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              if (topIcons != null && topIcons!.isNotEmpty) _buildTopIconsSection(context),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: disableBackButton
              ? SizedBox(width: MediaQuery.of(context).size.width * 0.16)
              : BackButtonWithTitle(
                  title: "Back",
                  onPressed: onBackPressed,
                ),
        ),
        TitleWidget(title: title),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 0.0, top: 0.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: topRightButton ?? Image.asset('assets/alfa_klebstoffe.png'),
            ),
          ),
        ),
      ],
    );
  }

Widget _buildTopIconsSection(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.22,
    decoration: BoxDecoration(
      border: Border.all(color: customButtonBorderColor, width: 0.0),
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: topIcons!
              .map<Widget>((iconData) => TopIconsButton(
                    imagePath: iconData['iconPath'] as String,
                    iconData: iconData,
                    filters: filters,
                    adhesiveService: adhesiveService,
                    previousCategorySlide: this, // ✅ Pass correct previous slide
                  ))
              .toList(), // ✅ Ensures correct type
        ),
      ],
    ),
  );
}


  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
      child: MiddleGrid(
        items: customButtonData ?? [],
        onItemTap: onItemTap ?? (label) {},
        crossAxisCount: gridColumns,
      ),
    );
  }
}
