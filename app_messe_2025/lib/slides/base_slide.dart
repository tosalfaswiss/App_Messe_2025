import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/ui_utils.dart';
import '../widgets/title_widget.dart';
import '../widgets/back_button_with_title.dart';
import '../widgets/top_icons_button.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../widgets/middle_grid.dart';
import '../utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BaseSlide extends StatelessWidget {
  final String title;
  final Widget? topRightButton;
  final List<Map<String, dynamic>>? customButtonData;
  final void Function(String label)? onItemTap;
  final bool disableBackButton;
  final AdhesiveService adhesiveService;
  final void Function() onBackPressed;
  final int gridColumns;

  const BaseSlide({
    Key? key,
    required this.title,
    this.topRightButton,
    this.customButtonData,
    this.onItemTap,
    this.disableBackButton = false,
    required this.adhesiveService,
    required this.onBackPressed,
    this.gridColumns = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();
    final topIcons = generateTopIcons(filters);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.03),

                SizedBox(
                  height: height * 0.12,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        disableBackButton
                            ? SizedBox(width: width * 0.16)
                            : BackButtonWithTitle(
                                title: "Back",
                                onPressed: onBackPressed,
                              ),
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              title,
                              style: getTitleTextStyle(context),
                              maxLines: 1,
                              minFontSize: 32,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: width * 0.25,
                            maxHeight: height * 0.12,
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: topRightButton ??
                              Image.asset(
                                'assets/alfa_klebstoffe.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox.shrink(),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                topIcons.isNotEmpty
                    ? Expanded(
                        flex: 2,
                        child: _buildTopIconsSection(context, height, topIcons, filters),
                      )
                    : SizedBox(height: height * 0.2),

                SizedBox(height: height * 0.02),

                Expanded(
                  flex: 5,
                  child: _buildBottomSheet(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopIconsSection(BuildContext context, double height, List<Map<String, dynamic>> topIcons, Filters filters) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: customButtonBorderColor,
              width: customButtonBorderWidth,
            ),
            borderRadius: BorderRadius.circular(getBorderRadius(context)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(height * 0.01),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < topIcons.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 0 : height * 0.005,
                    right: i == topIcons.length - 1 ? 0 : height * 0.005,
                  ),
                  child: TopIconsButton(
                    imagePath: topIcons[i]['iconPath'] as String,
                    iconData: topIcons[i],
                    filters: filters,
                    adhesiveService: adhesiveService,
                    previousCategorySlide: this,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: MiddleGrid(
        items: customButtonData ?? [],
        onItemTap: onItemTap ?? (label) {},
        crossAxisCount: gridColumns,
        crossAxisSpacing: getGridSpacing(context),
        mainAxisSpacing: getGridSpacing(context),
      ),
    );
  }
}
