import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/adhesive.dart';
import '../models/filters.dart';
import '../constants.dart';

class AdhesiveService {
  List<Adhesive> adhesives = [];
  List<String> applications = [];
  List<String> formulations = [];
  List<String> types = [];
  List<String> materials = [];

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
    print("filters");
    print(filters);

    List<Adhesive> filteredAdhesives = adhesives.where((adhesive) {
      return (filters.industry == null || adhesive.industries.contains(filters.industry)) &&
            (filters.application == null || adhesive.applications.contains(filters.application)) &&
            (filters.formulation == null || adhesive.formulations.contains(filters.formulation)) &&
            (filters.type == null || adhesive.types.contains(filters.type)) &&
            (filters.material == null || adhesive.materials.contains(filters.material));
    }).toList();

    print("\nFiltered Adhesives:");
    for (var adhesive in filteredAdhesives) {
      print(adhesive);
    }

    return filteredAdhesives;
  }


  List<String> getResultsForSlide(Filters filters) {
    // Get filtered adhesives
    final filteredAdhesives = filterAdhesives(filters);

    // Extract and return the `results` field from each adhesive for the slide
    return filteredAdhesives
        .expand((adhesive) => adhesive.results)
        .toSet() // Remove duplicates
        .toList();
  }

bool isOptionAvailable(String filterType) {
  filterType = filterType.toLowerCase();
   
  switch (filterType) {
    case 'types':
      int count = adhesives.fold(0, (sum, adhesive) => sum + adhesive.types.length);
      return count > 0;
    case 'formulations':
      int count = adhesives.fold(0, (sum, adhesive) => sum + adhesive.formulations.length);
      return count > 0;
    case 'materials':
      int count = adhesives.fold(0, (sum, adhesive) => sum + adhesive.materials.length);
      return count > 0;
    case 'applications':
      int count = adhesives.fold(0, (sum, adhesive) => sum + adhesive.applications.length);
      return count > 0;
    default:
      return false; // Return false for unsupported categories
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

  /// Generic method to get available options for a specific category
  List<String> _getAvailableOptions(Filters filters, String category) {
    final filteredAdhesives = filterAdhesives(filters);
    
    // Normalize the category input (lowercase and singular handling)
    final normalizedCategory = category.toLowerCase().replaceAll(RegExp(r's$'), '');

    // Use a Set to avoid duplicates
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
    print("give me the filteradhesives $options.toList()");
    return options.toList();
  }

  List<Map<String, dynamic>> buildCategories(Filters filters) {

    // Dynamically build the categories list using `isOptionAvailable`
    return [
      if (filters.application == null &&
          isOptionAvailable('Applications'))
        {
          'label': 'Application',
          'iconPath': applicationIconPath,
          'options': getApplications(filters),
        },
      if (filters.formulation == null &&
          isOptionAvailable('Formulations'))
        {
          'label': 'Formulation',
          'iconPath': formulationIconPath,
          'options': getFormulations(filters),
        },
      if (filters.material == null &&
          isOptionAvailable('Materials'))
        {
          'label': 'Material',
          'iconPath': materialsIconPath,
          'options': getMaterials(filters), 
        },
      // Add "Show Selection" button if any category is selected
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
