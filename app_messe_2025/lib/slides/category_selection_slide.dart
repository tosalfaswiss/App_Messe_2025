import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_slide.dart';
import 'results_slide.dart';
import 'category_detail_slide.dart';
import '../services/adhesive_service.dart';
import '../widgets/top_right_button.dart';
import '../constants.dart';
import '../utils/utils.dart';
import '../models/filters.dart';

class CategorySelectionSlide extends StatefulWidget {
  final AdhesiveService adhesiveService;

  const CategorySelectionSlide({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  _CategorySelectionSlideState createState() => _CategorySelectionSlideState();
}

class _CategorySelectionSlideState extends State<CategorySelectionSlide> {
  @override
  void initState() {
    super.initState();

    // Post-frame check to skip ahead if only "Show Selection" is needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filters = context.read<Filters>();
      final isOnlyShowSelection = onlyShowSelectionAvailable(filters, widget.adhesiveService);
      if (isOnlyShowSelection) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsSlide(
              adhesiveService: widget.adhesiveService,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<Filters>();
    final topIcons = generateTopIcons(filters);
    final categories = widget.adhesiveService.buildCategories(filters);

    final gridItems = categories.map((category) {
      return {
        'label': category['label'] as String,
        'iconPath': category['iconPath'] as String,
        'isDisabled': false,
      };
    }).toList();

    return BaseSlide(
      title: "Select Category",
      adhesiveService: widget.adhesiveService,
      topRightButton: TopRightButton(
        adhesiveService: widget.adhesiveService,
      ),
      onBackPressed: () {
        filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      customButtonData: gridItems,
      onItemTap: (label) {
        if (label == showSelectionButtonText && !isAnyCategorySelected(categories)) {
          return;
        }

        if (label == showSelectionButtonText) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsSlide(
                adhesiveService: widget.adhesiveService,
              ),
            ),
          );
        } else {
          final selectedCategory = categories.firstWhere((c) => c['label'] == label);
          final options = selectedCategory['options'] as List<String>;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailSlide(
                adhesiveService: widget.adhesiveService,
                title: "Select $label",
                categoryType: label,
                options: options,
                previousCategorySlide: widget,
              ),
            ),
          );
        }
      },
      gridColumns: 3,
    );
  }

  bool isAnyCategorySelected(List<Map<String, dynamic>> categories) {
    return categories.any((category) {
      final options = category['options'] as List;
      return options.isNotEmpty;
    });
  }
}
