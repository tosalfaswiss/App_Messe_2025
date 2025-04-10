import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/adhesive.dart';
import '../models/filters.dart';
import '../constants.dart';

const Map<String, String> typeLabelMapping = {
  'Water-based Adhesives': 'Water-based',
  'Hotmelt Adhesives': 'Hotmelt',
  'Coatings': 'Coatings',
};

class AdhesiveService {
  List<Adhesive> adhesives = [];
  List<String> applications = [];
  List<String> formulations = [];
  List<String> types = [];
  List<String> materials = [];
  final List<String> excludedTypes = [
  'Chlorine-free Adhesives',
];


  AdhesiveService();

  Future<void> loadData() async {
    try {
      print("Loading JSON data from assets/adhesives.json...");
      final String response = await rootBundle.loadString('assets/adhesives.json');

      final Map<String, dynamic> data = json.decode(response);

      adhesives = (data['adhesives'] as List).map((item) => Adhesive.fromJson(item)).toList();
      applications = List<String>.from(data['applications']);
      formulations = List<String>.from(data['formulations']);
      types = List<String>.from(data['types']);
      materials = List<String>.from(data['materials']);

    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  List<Adhesive> filterAdhesives(Filters filters) {
    print("Filters applied:");
    print(filters);

    List<Adhesive> filteredAdhesives = adhesives.where((adhesive) {
      final matchesIndustry = filters.industry == null || adhesive.industries.contains(filters.industry);
      final matchesApplication = filters.application == null || adhesive.applications.contains(filters.application);
      final matchesFormulation = filters.formulation == null || adhesive.formulations.contains(filters.formulation);
      final matchesType = filters.type == null || adhesive.types.contains(filters.type);
      final matchesMaterial = filters.material == null || adhesive.materials.contains(filters.material);

      return matchesIndustry && matchesApplication && matchesFormulation && matchesType && matchesMaterial;
    }).toList();

    print("\nFiltered Adhesives Found: ${filteredAdhesives.length}");
    for (var adhesive in filteredAdhesives) {
      print(adhesive);
    }

    return filteredAdhesives;
  }

  List<String> getResultsForSlide(Filters filters) {
    final filteredAdhesives = filterAdhesives(filters);
    return filteredAdhesives
        .expand((adhesive) => adhesive.results)
        .toSet()
        .toList();
  }

  bool isOptionAvailable(String filterType) {
    filterType = filterType.toLowerCase();

    switch (filterType) {
      case 'types':
        return adhesives.any((adhesive) => adhesive.types.isNotEmpty);
      case 'formulations':
        return adhesives.any((adhesive) => adhesive.formulations.isNotEmpty);
      case 'materials':
        return adhesives.any((adhesive) => adhesive.materials.isNotEmpty);
      case 'applications':
        return adhesives.any((adhesive) => adhesive.applications.isNotEmpty);
      default:
        return false;
    }
  }

  List<String> getMaterials(Filters filters) {
    return _getAvailableOptions(filters, 'materials');
  }

  List<String> getFormulations(Filters filters) {
    return _getAvailableOptions(filters, 'formulations');
  }

  List<String> getTypes(Filters filters) {
    return _getAvailableOptions(filters, 'types');
  }

  List<String> getApplications(Filters filters) {
    return _getAvailableOptions(filters, 'applications');
  }

  List<String> getAvailableOptions(Filters filters, String categoryType) {
    return _getAvailableOptions(filters, categoryType);
  }

  List<String> _getAvailableOptions(Filters filters, String category) {
    final filteredAdhesives = filterAdhesives(filters);
    final normalizedCategory = category.toLowerCase().replaceAll(RegExp(r's$'), '');

    final options = <String>{};
    for (var adhesive in filteredAdhesives) {
      switch (normalizedCategory) {
        case 'material':
          options.addAll(adhesive.materials);
          break;
        case 'formulation':
          options.addAll(adhesive.formulations);
          break;
        case 'type':
          options.addAll(adhesive.types);
          break;
        case 'application':
          options.addAll(adhesive.applications);
          break;
      }
    }
    print("Available options for '$category': ${options.toList()}");
    return options.toList();
  }

  List<Map<String, String>> getAvailableTypes(Filters filters) {
    final filteredAdhesives = filterAdhesives(filters);

    final uniqueTypes = <String>{};
    for (final adhesive in filteredAdhesives) {
      uniqueTypes.addAll(adhesive.types);
    }

    final typesList = uniqueTypes
        .where((filterValue) => !excludedTypes.contains(filterValue))
        .toList();

    // Sort them according to adhesiveTypeOrder
    typesList.sort((a, b) {
      return adhesiveTypeOrder.indexOf(a).compareTo(adhesiveTypeOrder.indexOf(b));
    });

    return typesList.map((filterValue) {
      final label = typeLabelMapping[filterValue] ?? filterValue;

      return {
        'label': label,
        'filterValue': filterValue,
        'iconPath': 'assets/${label.toLowerCase().replaceAll(' ', '_')}_icon.png',
      };
    }).toList();
  }

  List<Map<String, dynamic>> buildCategories(Filters filters) {
    return [
      if (filters.application == null && isOptionAvailable('Applications'))
        {
          'label': 'Application',
          'iconPath': applicationIconPath,
          'options': getApplications(filters),
        },
      if (filters.formulation == null && isOptionAvailable('Formulations'))
        {
          'label': 'Formulation',
          'iconPath': formulationIconPath,
          'options': getFormulations(filters),
        },
      if (filters.material == null && isOptionAvailable('Materials'))
        {
          'label': 'Material',
          'iconPath': materialsIconPath,
          'options': getMaterials(filters),
        },
      if (filters.isAnyCategorySelected())
        {
          'label': showSelectionButtonText,
          'iconPath': showSelectionIconPath,
          'options': <String>[],
          'isDisabled': !filters.isAnyCategorySelected(),
        },
    ];
  }
}
