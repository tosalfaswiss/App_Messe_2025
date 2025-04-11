import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'adhesive_type_selection_slide.dart';
import 'base_slide.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';
import '../widgets/top_right_button.dart';
import '../utils/utils.dart';

class IndustrySlide extends StatefulWidget {
  final AdhesiveService adhesiveService;

  const IndustrySlide({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  State<IndustrySlide> createState() => _IndustrySlideState();
}

class _IndustrySlideState extends State<IndustrySlide> {
  @override
  void initState() {
    super.initState();
    // Defer filter mutation until after the first build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filters = context.read<Filters>();
      final savedIndustry = filters.industry;

      filters.reset();
      filters.updateField('industry', savedIndustry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();
    final industries = buildIndustries();

    final industryItems = industries.map((industry) {
      return {
        'label': industry['label'] as String,
        'iconPath': industry['iconPath'] as String,
      };
    }).toList();

    return BaseSlide(
      title: industrySlideTitle, // This constant will trigger the "Exit" label.
      disableBackButton: false, // Enable the top‑left button.
      // onBackPressed now exits the app.
      onBackPressed: () {
        SystemNavigator.pop();
      },
      adhesiveService: widget.adhesiveService,
      topRightButton: TopRightButton(
        adhesiveService: widget.adhesiveService,
      ),
      customButtonData: industryItems,
      onItemTap: (label) {
        filters.updateField('industry', label);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdhesiveTypeSelectionSlide(
              adhesiveService: widget.adhesiveService,
            ),
          ),
        );
      },
      gridColumns: 4,
    );
  }
}
