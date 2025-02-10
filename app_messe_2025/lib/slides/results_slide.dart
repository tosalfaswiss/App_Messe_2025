import 'package:flutter/material.dart';
import 'base_slide.dart';
import '../constants.dart';
import '../models/adhesive.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart'; // Utility functions

class ResultsSlide extends StatelessWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;

  ResultsSlide({Key? key, required this.filters, required this.adhesiveService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) Filter adhesives based on the current filters (ALWAYS returns results)
    final List<Adhesive> results = adhesiveService.filterAdhesives(filters);

    // 2) Generate top icons dynamically
    final topIcons = generateTopIcons(filters);

    // 3) Convert adhesives into a list of data maps for `MiddleGrid`
    final buttonData = results.map((adhesive) {
      return {
        'label': adhesive.name,
        'iconPath': 'assets/${adhesive.results.first.toLowerCase().replaceAll(' ', '_')}_result.png',
        'isDisabled': false, // Always enabled since results exist
      };
    }).toList();

    // 4) Build `BaseSlide` and correctly pass adhesives
    return BaseSlide(
      title: "Results",
      topRightButton: TopRightButton(
        filters: filters,
        adhesiveService: adhesiveService,
      ),
      topIcons: topIcons,
      filters: filters,
      adhesiveService: adhesiveService,
      customButtonData: buttonData,
      onBackPressed: () {
        print("Back button pressed"); // Debugging Log
        filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          print("Navigator can pop"); // Debugging Log
          Navigator.pop(context);
        } else {
          print("Navigator cannot pop, stuck at root?"); // Debugging Log
        }
      },
      onItemTap: (label) {
        // Find the selected adhesive (guaranteed to exist)
        final selectedAdhesive = results.firstWhere((adhesive) => adhesive.name == label);

        // Show dialog with adhesive details
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
