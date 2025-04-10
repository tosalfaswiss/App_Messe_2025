import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../slides/base_slide.dart';
import '../widgets/top_right_button.dart';
import 'category_selection_slide.dart';
import '../constants.dart';
import '../utils/utils.dart';

class CategoryDetailSlide extends StatelessWidget {
  final AdhesiveService adhesiveService;
  final String title;
  final String categoryType;
  final List<String> options;
  final Widget previousCategorySlide;

  const CategoryDetailSlide({
    Key? key,
    required this.adhesiveService,
    required this.title,
    required this.categoryType,
    required this.options,
    required this.previousCategorySlide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();

    final String currentSelection = getCurrentSelection(filters, categoryType);
    final topIcons = generateTopIcons(filters);

    final List<Map<String, dynamic>> itemData = [
      ...options.map((option) => {
            'label': option,
            'iconPath': 'assets/${option.toLowerCase().replaceAll(' ', '_')}.png',
            'isDisabled': false,
          }),
      {
        'label': 'Deselect',
        'iconPath': deselectIconPath,
        'isDisabled': currentSelection.isEmpty,
      },
    ];

    return BaseSlide(
      title: title,
      adhesiveService: adhesiveService,
      topRightButton: TopRightButton(
        adhesiveService: adhesiveService,
      ),
      customButtonData: itemData,
      onItemTap: (label) {
        if (label == 'Deselect') {
          filters.resetFilterByCategory(categoryType);
        } else {
          filters.updateField(categoryType, label);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionSlide(
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
