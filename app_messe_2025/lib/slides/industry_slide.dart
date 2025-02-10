import 'package:flutter/material.dart';
import 'adhesive_type_selection_slide.dart';
import 'base_slide.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart'; // Utility functions

class IndustrySlide extends StatelessWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;

  IndustrySlide({
    Key? key,
    required this.filters,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) Reset and restore the "industry" filter
    final savedIndustry = filters.industry;
    filters.reset();
    filters.updateField('industry', savedIndustry);

    // 2) Generate the industry data (label/iconPath) via utility
    final industries = buildIndustries(); 

    // 3) Build top icons, if needed
    final topIcons = generateTopIcons(filters);

    // 4) Convert industries into a format compatible with `MiddleGrid`
    final industryItems = industries.map((industry) {
      return {
        'label': industry['label'] as String,
        'iconPath': industry['iconPath'] as String,
      };
    }).toList();

    // 5) Use `BaseSlide` with 3-column grid
    return BaseSlide(
      title: "Which industry are you working in?",
      filters: filters,
      disableBackButton: true,
      onBackPressed: defaultOnBackPressed,
      adhesiveService: adhesiveService,

      // Optional top-right button (logo or action)
      topRightButton: TopRightButton(
        filters: filters,
        adhesiveService: adhesiveService,
      ),

      // The dynamic top icons
      topIcons: topIcons,

      // Pass industry data instead of `CustomButton` instances
      customButtonData: industryItems,

      // Handle item taps separately
      onItemTap: (label) {
        // Update the filter with the selected industry
        filters.updateField('industry', label);

        // Navigate to the next slide
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdhesiveTypeSelectionSlide(
              filters: filters,
              adhesiveService: adhesiveService,
            ),
          ),
        );
      },

      gridColumns: 3,
    );
  }
}
