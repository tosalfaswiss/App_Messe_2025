class Filters {
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
      industry: this.industry,
      application: this.application,
      formulation: this.formulation,
      type: this.type,
      material: this.material,
      results: this.results != null ? List<String>.from(this.results!) : null,
    )..updateHistory = List<String>.from(this.updateHistory);
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
      fields[fieldName]!(); // Clear the specific field
      updateHistory.remove(fieldName); 
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
  }

  // Reset the most recently updated field
  void resetLastUpdatedField() {
    if (updateHistory.isNotEmpty) {
      String lastField = updateHistory.removeLast();
      clearField(lastField);
    } else {
      print('No fields to reset.');
    }
  }

  // Check if required fields are complete
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

  /// Resets a filter by category type.
  void resetFilterByCategory(String categoryType) {
    final fieldMap = {
      'application': () => application = null,
      'formulation': () => formulation = null,
      'material': () => material = null,
      'industry': () => industry = null,
      'type': () => type = null,
    };

    if (fieldMap.containsKey(categoryType.toLowerCase())) {
      fieldMap[categoryType.toLowerCase()]!();
      updateHistory.remove(categoryType.toLowerCase());
    } else {
      print("resetFilterByCategory: couldn't reset '$categoryType'");
    }
  }

  void deselectLastFilter() {
    if (updateHistory.isNotEmpty) {
      // Get the last updated field
      String lastField = updateHistory.removeLast();

      // Clear the corresponding field
      clearField(lastField);
    } else {
      print('No filters to reset.');
    }
  }

    /// Checks if any category filter is selected.
  bool isAnyCategorySelected() {
    return application != null || formulation != null || material != null;
  }
}
