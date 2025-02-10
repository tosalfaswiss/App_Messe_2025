import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../slides/category_detail_slide.dart';
import '../slides/industry_slide.dart';
import '../slides/adhesive_type_selection_slide.dart';

Map<String, String> filterToIconMap(Filters filters) {
  return {
    if (filters.industry != null)
      'Industry': 'assets/${filters.industry!.toLowerCase().replaceAll(' ', '_')}.png',
    if (filters.type != null)
      'Type': 'assets/${filters.type!.toLowerCase().replaceAll(' ', '_')}.png',
    if (filters.application != null)
      'Application': 'assets/${filters.application!.toLowerCase().replaceAll(' ', '_')}.png',
    if (filters.formulation != null)
      'Formulation': 'assets/${filters.formulation!.toLowerCase().replaceAll(' ', '_')}.png',
    if (filters.material != null)
      'Material': 'assets/${filters.material!.toLowerCase().replaceAll(' ', '_')}.png',
  };
}

List<Map<String, dynamic>> generateTopIcons(Filters filters) {

  // Collect current filter values
  final currentValues = {
    'industry':    filters.industry,
    'application': filters.application,
    'formulation': filters.formulation,
    'type':        filters.type,
    'material':    filters.material,
  };

  // Build a list of top icons for each filter that has a set value
  List<Map<String, dynamic>> topIcons = currentValues.entries
      .where((entry) => entry.value != null) // Only filters that have a non-null value
      .map((entry) {
        final filterKey   = entry.key;        // e.g. "industry", "formulation"
        final optionValue = entry.value as String; // e.g. "biobased", "Upholstery"

        // Convert "Biobased" -> "biobased", "Hot Melt" -> "hot_melt", etc.
        final iconFileName = optionValue.toLowerCase().replaceAll(' ', '_');

        return {
          'filterKey': filterKey,  // The filter type (e.g. "industry")
          'label': optionValue,    // The selected option name
          'iconPath': 'assets/$iconFileName.png', // Dynamic icon path
        };
      })
      .toList();

  // Sort `topIcons` based on `filters.updateHistory`
  topIcons.sort((a, b) {
    int indexA = filters.updateHistory.indexOf(a['filterKey']);
    int indexB = filters.updateHistory.indexOf(b['filterKey']);
    return indexA.compareTo(indexB);
  });

  return topIcons;
}

/// Maps selected filters to a list of icons.
List<Map<String, dynamic>> mapSelectedIcons(Filters filters) {
  final filterIcons = filterToIconMap(filters);
  return filterIcons.values.map((iconPath) => {'iconPath': iconPath}).toList();
}


/// Builds a list of industries for IndustrySlide.
List<Map<String, dynamic>> buildIndustries() {
  return [
    {'label': 'Mattress', 'iconPath': mattressIconPath, 'options': []},
    {'label': 'Upholstery', 'iconPath': upholsteryIconPath, 'options': []},
    {'label': 'Automotive', 'iconPath': automotiveIconPath, 'options': []},
  ];
}

/// Determines if only the "Show Selection" option is available.
bool onlyShowSelectionAvailable(Filters filters, AdhesiveService adhesiveService) {
  return (filters.application != null &&
          filters.formulation != null &&
          filters.material != null) ||
      (adhesiveService.applications.isEmpty &&
          adhesiveService.formulations.isEmpty &&
          adhesiveService.materials.isEmpty &&
          filters.isAnyCategorySelected());
}

/// Gets the current selection for a specific category type.
String getCurrentSelection(Filters filters, String categoryType) {
  switch (categoryType.toLowerCase()) {
    case 'application':
      return filters.application ?? '';
    case 'formulation':
      return filters.formulation ?? '';
    case 'material':
      return filters.material ?? '';
    default:
      print("missing getCurrentSelection $categoryType");
      return '';
  }
}

void defaultOnBackPressed() {}

void handleTopIconClick(
    BuildContext context, Map<String, dynamic> iconData, Filters filters, AdhesiveService adhesiveService, Widget previousCategorySlide) {
  final filterKey = iconData['filterKey'] as String;

  if (filterKey == 'industry') {
    filters.reset(); // Reset all filters
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndustrySlide(
          filters: filters, // Use original filters since everything is reset
          adhesiveService: adhesiveService,
        ),
      ),
    );
  } else if (filterKey == 'type') {
    // Reset material, application, and formulation when selecting adhesive type
    filters.resetFilterByCategory('material');
    filters.resetFilterByCategory('application');
    filters.resetFilterByCategory('formulation');
    filters.resetFilterByCategory('type');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdhesiveTypeSelectionSlide(
          filters: filters, // Use original filters since we reset categories
          adhesiveService: adhesiveService,
        ),
      ),
    );
  } else {
    // ✅ Only copy filters for category selection cases
    final tempFilters = filters.copy();
    tempFilters.resetFilterByCategory(filterKey);
    final options = adhesiveService.getAvailableOptions(tempFilters, filterKey).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailSlide(
          filters: filters, 
          adhesiveService: adhesiveService,
          title: "Select ${iconData['label']}",
          categoryType: filterKey,
          options: options,
          previousCategorySlide: previousCategorySlide, // Ensure correct navigation
        ),
      ),
    );
  }
}
