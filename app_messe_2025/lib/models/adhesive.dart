class Adhesive {
  final String name;
  final List<String> industries;
  final List<String> applications;
  final List<String> formulations;
  final List<String> types;
  final List<String> materials;
  final List<String> results; // Results property as a required field

  Adhesive({
    required this.name,
    required this.industries,
    required this.applications,
    required this.formulations,
    required this.types,
    required this.materials,
    required this.results, // Results is now required
  });

  factory Adhesive.fromJson(Map<String, dynamic> json) {
    return Adhesive(
      name: json['name'],
      industries: List<String>.from(json['industries']),
      applications: List<String>.from(json['applications']),
      formulations: List<String>.from(json['formulations']),
      types: List<String>.from(json['types']),
      materials: List<String>.from(json['materials']),
      results: List<String>.from(json['results']), 
    );
  }

  @override
  String toString() {
    return 'Adhesive(name: $name, industries: $industries, applications: $applications, formulations: $formulations, types: $types, materials: $materials, results: $results)';
  }
}
