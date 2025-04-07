import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_selection_slide.dart';
import 'results_slide.dart';
import 'base_slide.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart';

class AdhesiveTypeSelectionSlide extends StatelessWidget {
  final AdhesiveService adhesiveService;

  const AdhesiveTypeSelectionSlide({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();

    // 1) Define adhesive types
    final types = [
      {'label': 'Water-based', 'iconPath': 'assets/water_based_icon.png'},
      {'label': 'Hotmelt',     'iconPath': 'assets/hotmelt_icon.png'},
    ];

    // 2) Evaluate availability per type
    final availableTypes = types.map((type) {
      final tempFilters = filters.copy();
      tempFilters.type = type['label'];
      final isAvailable = adhesiveService.filterAdhesives(tempFilters).isNotEmpty;
      return {
        ...type,
        'isDisabled': !isAvailable,
      };
    }).toList();

    // 3) Auto-forward to results if no valid types
    final validTypes = availableTypes.where((type) => !(type['isDisabled'] as bool)).toList();
    if (validTypes.isEmpty) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsSlide(
              adhesiveService: adhesiveService,
            ),
          ),
        );
      });
      return const SizedBox(); // Temporary render while navigating
    }

    // 4) Prepare button data
    final typeItems = availableTypes.map((type) {
      return {
        'label': type['label'] as String,
        'iconPath': type['iconPath'] as String,
        'isDisabled': type['isDisabled'] as bool,
      };
    }).toList();

    // 5) Build UI
    return BaseSlide(
      title: "Select Adhesive Type",
      adhesiveService: adhesiveService,
      topRightButton: TopRightButton(
        adhesiveService: adhesiveService,
      ),
      disableBackButton: false,
      onBackPressed: () {
        filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      customButtonData: typeItems,
      onItemTap: (label) {
        filters.updateField("type", label);
        final remainingValid = adhesiveService.filterAdhesives(filters);

        if (remainingValid.isEmpty || remainingValid.length == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsSlide(
                adhesiveService: adhesiveService,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorySelectionSlide(
                adhesiveService: adhesiveService,
              ),
            ),
          );
        }
      },
    );
  }
}
