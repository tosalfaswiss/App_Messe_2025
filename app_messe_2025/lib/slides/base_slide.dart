import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/title_widget.dart';
import '../widgets/back_button_with_title.dart';
import '../widgets/top_icons_button.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../widgets/middle_grid.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2% top padding
            SizedBox(height: height * 0.02),
            // Header row: 18% of height
            SizedBox(
              height: height * 0.18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    disableBackButton
                        ? SizedBox(width: width * 0.16)
                        : BackButtonWithTitle(
                            title: "Back",
                            onPressed: onBackPressed,
                          ),
                    Expanded(child: Center(child: TitleWidget(title: title))),
                    SizedBox(
                      width: width * 0.2,
                      child: topRightButton ??
                          Image.asset(
                            'assets/alfa_klebstoffe.png',
                            fit: BoxFit.contain,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            // 2% padding below header
            SizedBox(height: height * 0.02),
            // Top icons section: 20% of height
            SizedBox(
              height: height * 0.2,
              child: _buildTopIconsSection(context),
            ),
            // 2% padding below top icons
            SizedBox(height: height * 0.02),
            // MiddleGrid section: 56% of height
            SizedBox(
              height: height * 0.56,
              child: _buildBottomSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIconsSection(BuildContext context) {
    if (topIcons != null && topIcons!.isNotEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
          border: Border.all(color: customButtonBorderColor, width: 0.0),
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
        ),
        child: Wrap(
          alignment: WrapAlignment.start,
          children: topIcons!
              .map<Widget>((iconData) => TopIconsButton(
                    imagePath: iconData['iconPath'] as String,
                    iconData: iconData,
                    filters: filters,
                    adhesiveService: adhesiveService,
                    previousCategorySlide: this,
                  ))
              .toList(),
        ),
      );
    } else {
      // Reserve space for top icons even when empty.
      return SizedBox(height: MediaQuery.of(context).size.height * 0.2);
    }
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
      child: MiddleGrid(
        items: customButtonData ?? [],
        onItemTap: onItemTap ?? (label) {},
        crossAxisCount: gridColumns,
      ),
    );
  }
}
