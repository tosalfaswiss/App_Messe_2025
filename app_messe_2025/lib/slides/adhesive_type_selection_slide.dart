import 'package:flutter/material.dart';
import 'category_selection_slide.dart';
import 'results_slide.dart';
import 'base_slide.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart'; 

class AdhesiveTypeSelectionSlide extends StatelessWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;

  const AdhesiveTypeSelectionSlide({
    Key? key,
    required this.filters,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) Define possible adhesive types
    final types = [
      {'label': 'Water-based', 'iconPath': 'assets/water_based_icon.png'},
      {'label': 'Hotmelt',     'iconPath': 'assets/hotmelt_icon.png'},
    ];

    // 2) Check availability for each type based on the filtered adhesives
    final availableTypes = types.map((type) {
      final tempFilters = filters.copy();
      tempFilters.type = type['label'];
      final isAvailable = adhesiveService.filterAdhesives(tempFilters).isNotEmpty;
      return {
        ...type,
        'isDisabled': !isAvailable, // Mark as disabled if no adhesives available
      };
    }).toList();

    // 3) If no valid types, skip directly to ResultsSlide
    final validTypes = availableTypes.where((type) => !(type['isDisabled'] as bool)).toList();
    if (validTypes.isEmpty) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsSlide(
              filters: filters,
              adhesiveService: adhesiveService,
            ),
          ),
        );
      });
      return const SizedBox(); // Render an empty widget while navigating
    }

    // 4) Generate top icons dynamically
    final topIcons = generateTopIcons(filters);

    // 5) Convert types into a list for MiddleGrid
    final typeItems = availableTypes.map((type) {
      return {
        'label': type['label'] as String,
        'iconPath': type['iconPath'] as String,
        'isDisabled': type['isDisabled'] as bool,
      };
    }).toList();

    // 6) Use BaseSlide with onItemTap logic
    return BaseSlide(
      title: "Select Adhesive Type",
      filters: filters,
      adhesiveService: adhesiveService,
      topRightButton: TopRightButton(
        filters: filters,
        adhesiveService: adhesiveService,
      ),
      topIcons: topIcons,
      disableBackButton: false,
            onBackPressed: () {
        // Called when user taps the back button
        filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      customButtonData: typeItems, // Pass raw button data to BaseSlide
      onItemTap: (label) {
        // Ignore taps on disabled buttons (handled in MiddleGrid)
        filters.type = label;
        filters.updateField("type", label);
        // Check how many adhesives remain valid after applying this filter
        final remainingValidOptions = adhesiveService.filterAdhesives(filters);

        // If no or exactly one valid option is left, go directly to results
        if (remainingValidOptions.isEmpty || remainingValidOptions.length == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsSlide(
                filters: filters,
                adhesiveService: adhesiveService,
              ),
            ),
          );
        } else {
          // Otherwise, proceed to the category selection step
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorySelectionSlide(
                filters: filters,
                adhesiveService: adhesiveService,
              ),
            ),
          );
        }
      },
    );
  }
}