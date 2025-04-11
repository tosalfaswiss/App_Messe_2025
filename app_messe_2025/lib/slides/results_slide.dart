import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_slide.dart';
import '../constants.dart';
import '../models/adhesive.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart';

class ResultsSlide extends StatelessWidget {
  final AdhesiveService adhesiveService;

  const ResultsSlide({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();

    // 1) Filter adhesives based on current filters
    final List<Adhesive> results = adhesiveService.filterAdhesives(filters);

    // 2) Convert adhesives into data maps for MiddleGrid
    final buttonData = results.map((adhesive) {
      final resultName = adhesive.results.isNotEmpty
          ? adhesive.results.first.toLowerCase().replaceAll(' ', '_')
          : 'default';
      return {
        'label': adhesive.name,
        'iconPath': 'assets/${resultName}_result.png',
        'isDisabled': false,
      };
    }).toList();

    // 3) Build slide (even if empty, fallback to empty list)
    return BaseSlide(
      title: resultsSlideTitle,
      topRightButton: TopRightButton(
        adhesiveService: adhesiveService,
      ),
      adhesiveService: adhesiveService,
      customButtonData: buttonData,
      onBackPressed: () {
        filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onItemTap: (label) {
        final selectedAdhesive = results.firstWhere(
          (a) => a.name == label,
          orElse: () => Adhesive(
            name: "Unknown",
            industries: [],
            applications: [],
            formulations: [],
            types: [],
            materials: [],
            results: [],
            certificates: [], 
            meta: Meta(packaging: [], colors: []),
          ),
        );


        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(selectedAdhesive.name),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedAdhesive.meta.packaging.isNotEmpty) ...[
                    const Text('Packaging:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    ...selectedAdhesive.meta.packaging.map((p) => Text('- $p')).toList(),
                    const SizedBox(height: 12),
                  ],
                  if (selectedAdhesive.meta.colors.isNotEmpty) ...[
                    const Text('Colors:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: selectedAdhesive.meta.colors
                          .map((color) => Chip(label: Text(color)))
                          .toList(),
                    ),
                  ],
                  if (selectedAdhesive.certificates.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text('Certificates:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    ...selectedAdhesive.certificates.map((c) => Text('- $c')).toList(),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}
