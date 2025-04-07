import 'package:flutter/foundation.dart';

class Filters extends ChangeNotifier {
  String? industry;
  String? application;
  String? formulation;
  String? type;
  String? material;
  List<String>? results;
  List<String> updateHistory = [];

  Filters({
    this.industry,
    this.application,
    this.formulation,
    this.type,
    this.material,
    this.results,
  });

  // Create a copy of the Filters instance
  Filters copy() {
    return Filters(
      industry: industry,
      application: application,
      formulation: formulation,
      type: type,
      material: material,
      results: results != null ? List<String>.from(results!) : null,
    )..updateHistory = List<String>.from(updateHistory);
  }

  // Reset all fields
  void reset() {
    industry = null;
    application = null;
    formulation = null;
    type = null;
    material = null;
    results = null;
    updateHistory.clear();
    notifyListeners(); // 🔔
  }

  void clearField(String fieldName) {
    final fields = {
      'industry': () => industry = null,
      'application': () => application = null,
      'formulation': () => formulation = null,
      'type': () => type = null,
      'material': () => material = null,
    };

    if (fields.containsKey(fieldName)) {
      fields[fieldName]!();
      updateHistory.remove(fieldName);
      notifyListeners(); // 🔔
    } else {
      print('clearField Unknown field: $fieldName');
    }
  }

  // Update a specific field and manage update history
  void updateField(String fieldName, dynamic value) {
    fieldName = fieldName.toLowerCase();
    clearField(fieldName);

    switch (fieldName) {
      case 'industry':
        industry = value as String?;
        break;
      case 'application':
        application = value as String?;
        break;
      case 'formulation':
        formulation = value as String?;
        break;
      case 'type':
        type = value as String?;
        break;
      case 'material':
        material = value as String?;
        break;
      default:
        print('updateField Unknown field: $fieldName');
        return;
    }

    updateHistory.remove(fieldName);
    updateHistory.add(fieldName);
    notifyListeners(); // 🔔
  }

  // Reset the most recently updated field
  void resetLastUpdatedField() {
    if (updateHistory.isNotEmpty) {
      final lastField = updateHistory.removeLast();
      clearField(lastField);
      notifyListeners(); // 🔔
    } else {
      print('No fields to reset.');
    }
  }

  bool isComplete({List<String>? requiredFields}) {
    requiredFields ??= ['industry', 'application', 'type', 'material'];
    for (String field in requiredFields) {
      switch (field) {
        case 'industry':
          if (industry == null) return false;
          break;
        case 'application':
          if (application == null) return false;
          break;
        case 'type':
          if (type == null) return false;
          break;
        case 'material':
          if (material == null) return false;
          break;
        default:
          print('isComplete Unknown field: $field');
          return false;
      }
    }
    return true;
  }

  @override
  String toString() {
    return 'Filters(industry: $industry, application: $application, formulation: $formulation, type: $type, material: $material, results: $results, updateHistory: $updateHistory)';
  }

  void resetFilterByCategory(String categoryType) {
    final fieldMap = {
      'application': () => application = null,
      'formulation': () => formulation = null,
      'material': () => material = null,
      'industry': () => industry = null,
      'type': () => type = null,
    };

    final normalized = categoryType.toLowerCase();
    if (fieldMap.containsKey(normalized)) {
      fieldMap[normalized]!();
      updateHistory.remove(normalized);
      notifyListeners(); // 🔔
    } else {
      print("resetFilterByCategory: couldn't reset '$categoryType'");
    }
  }

  void deselectLastFilter() {
    if (updateHistory.isNotEmpty) {
      final lastField = updateHistory.removeLast();
      clearField(lastField);
      notifyListeners(); // 🔔
    } else {
      print('No filters to reset.');
    }
  }

  bool isAnyCategorySelected() {
    return application != null || formulation != null || material != null;
  }
}
