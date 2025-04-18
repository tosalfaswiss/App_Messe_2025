class Adhesive {
  final String name;
  final List<String> industries;
  final List<String> applications;
  final List<String> formulations;
  final List<String> types;
  final List<String> materials;
  final List<String> results;
  final List<String> certificates; // <-- NEW FIELD
  final Meta meta;  

  Adhesive({
    required this.name,
    required this.industries,
    required this.applications,
    required this.formulations,
    required this.types,
    required this.materials,
    required this.results,
    required this.certificates, // <-- NEW FIELD
    required this.meta,
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
      certificates: List<String>.from(json['certificates'] ?? []), // Defensive null handling
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Adhesive(name: $name, industries: $industries, applications: $applications, formulations: $formulations, types: $types, materials: $materials, results: $results, certificates: $certificates, meta: $meta)';
  }
}

class Meta {
  final List<String> packaging;
  final List<String> colors;

  Meta({
    required this.packaging,
    required this.colors,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      packaging: List<String>.from(json['packaging'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Meta(packaging: $packaging, colors: $colors)';
  }
}
