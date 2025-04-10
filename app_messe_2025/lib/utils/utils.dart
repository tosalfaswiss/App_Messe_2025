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
  final currentValues = {
    'industry': filters.industry,
    'application': filters.application,
    'formulation': filters.formulation,
    'type': filters.type,
    'material': filters.material,
  };

  List<Map<String, dynamic>> topIcons = currentValues.entries
      .where((entry) => entry.value != null)
      .map((entry) {
    final filterKey = entry.key;
    final optionValue = entry.value as String;
    final iconFileName = optionValue.toLowerCase().replaceAll(' ', '_');

    return {
      'filterKey': filterKey,
      'label': optionValue,
      'iconPath': 'assets/$iconFileName.png',
    };
  }).toList();

  topIcons.sort((a, b) {
    int indexA = filters.updateHistory.indexOf(a['filterKey']);
    int indexB = filters.updateHistory.indexOf(b['filterKey']);
    return indexA.compareTo(indexB);
  });

  return topIcons;
}

List<Map<String, dynamic>> mapSelectedIcons(Filters filters) {
  final filterIcons = filterToIconMap(filters);
  return filterIcons.values.map((iconPath) => {'iconPath': iconPath}).toList();
}

List<Map<String, dynamic>> buildIndustries() {
  return [
    {
      'label': 'Mattresses Manufacturing & Foam Converting',
      'iconPath': mattressIconPath,
      'options': [],
    },
    {
      'label': 'Upholstery & Office Furniture',
      'iconPath': upholsteryIconPath,
      'options': [],
    },
    {
      'label': 'Automotive & Transport',
      'iconPath': automotiveIconPath,
      'options': [],
    },
    {
      'label': 'Industrial Adhesives',
      'iconPath': industrialIconPath,
      'options': [],
    },
  ];
}

bool onlyShowSelectionAvailable(Filters filters, AdhesiveService adhesiveService) {
  final applications = adhesiveService.getApplications(filters);
  final formulations = adhesiveService.getFormulations(filters);
  final materials = adhesiveService.getMaterials(filters);

  final hasApplications = applications.isNotEmpty;
  final hasFormulations = formulations.isNotEmpty;
  final hasMaterials = materials.isNotEmpty;

  final hasOptionsLeft = hasApplications || hasFormulations || hasMaterials;

  print('onlyShowSelectionAvailable Debug:');
  print('Selected filters: $filters');
  print('Available Applications: ${applications.length} → $applications');
  print('Available Formulations: ${formulations.length} → $formulations');
  print('Available Materials: ${materials.length} → $materials');
  print('Has Options Left: $hasOptionsLeft');

  final shouldSkipToResults = !hasOptionsLeft ||
      (filters.application != null &&
          filters.formulation != null &&
          filters.material != null);

  print('Should Skip to Results: $shouldSkipToResults');

  return shouldSkipToResults;
}


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
  BuildContext context,
  Map<String, dynamic> iconData,
  Filters filters,
  AdhesiveService adhesiveService,
  Widget previousCategorySlide,
) {
  final filterKey = iconData['filterKey'] as String;

  if (filterKey == 'industry') {
    filters.reset();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndustrySlide(
          adhesiveService: adhesiveService,
        ),
      ),
    );
  } else if (filterKey == 'type') {
    filters.resetFilterByCategory('material');
    filters.resetFilterByCategory('application');
    filters.resetFilterByCategory('formulation');
    filters.resetFilterByCategory('type');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdhesiveTypeSelectionSlide(
          adhesiveService: adhesiveService,
        ),
      ),
    );
  } else {
    final tempFilters = filters.copy();
    tempFilters.resetFilterByCategory(filterKey);
    final options = adhesiveService.getAvailableOptions(tempFilters, filterKey).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailSlide(
          adhesiveService: adhesiveService,
          title: "Select ${iconData['label']}",
          categoryType: filterKey,
          options: options,
          previousCategorySlide: previousCategorySlide,
        ),
      ),
    );
  }
}
