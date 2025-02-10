import 'package:flutter/material.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../slides/base_slide.dart';
import '../widgets/top_right_button.dart';
import 'category_selection_slide.dart';
import '../constants.dart';
import '../utils/utils.dart';

class CategoryDetailSlide extends StatelessWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;
  final String title;
  final String categoryType;
  final List<String> options;
  final Widget previousCategorySlide;

  const CategoryDetailSlide({
    Key? key,
    required this.filters,
    required this.adhesiveService,
    required this.title,
    required this.categoryType,
    required this.options,
    required this.previousCategorySlide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the currently selected value (if any) for this category
    final String currentSelection = getCurrentSelection(filters, categoryType);

    // Generate dynamic top icons
    final topIcons = generateTopIcons(filters);

    // Build button data including a "Deselect" item
    final List<Map<String, dynamic>> itemData = [
      ...options.map((option) => {
            'label': option,
            'iconPath': 'assets/${option.toLowerCase().replaceAll(' ', '_')}.png',
            'isDisabled': false,
          }),
      {
        'label': 'Deselect',
        'iconPath': 'assets/deselect_icon.png',
        'isDisabled': currentSelection.isEmpty,
      },
    ];

    return BaseSlide(
      title: title,
      filters: filters,
      adhesiveService: adhesiveService,
      topRightButton: TopRightButton(
        filters: filters,
        adhesiveService: adhesiveService,
      ),
      topIcons: topIcons,
      customButtonData: itemData,
      onItemTap: (label) {
        // If "Deselect" is tapped, reset category filter
        if (label == 'Deselect') {
          filters.resetFilterByCategory(categoryType);
        } else {
          // Update the filter for this category
          filters.updateField(categoryType, label);
        }

        // Navigate back to CategorySelectionSlide
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionSlide(
              filters: filters,
              adhesiveService: adhesiveService,
            ),
          ),
        );
      },
      onBackPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }
}
