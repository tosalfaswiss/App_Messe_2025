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

    // 2) Generate top icons dynamically
    final topIcons = generateTopIcons(filters);

    // 3) Convert adhesives into data maps for MiddleGrid
    final buttonData = results.map((adhesive) {
      return {
        'label': adhesive.name,
        'iconPath': 'assets/${adhesive.results.first.toLowerCase().replaceAll(' ', '_')}_result.png',
        'isDisabled': false,
      };
    }).toList();

    // 4) Build BaseSlide
    return BaseSlide(
      title: "Results",
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
        final selectedAdhesive = results.firstWhere((a) => a.name == label);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Adhesive Selected"),
            content: Text("You selected: ${selectedAdhesive.name}"),
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
