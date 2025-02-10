import 'package:flutter/material.dart';
import 'base_slide.dart';
import 'results_slide.dart';
import 'category_detail_slide.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../widgets/top_right_button.dart';
import '../constants.dart';
import '../utils/utils.dart';

class CategorySelectionSlide extends StatefulWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;

  CategorySelectionSlide({required this.filters, required this.adhesiveService});

  @override
  _CategorySelectionSlideState createState() => _CategorySelectionSlideState();
}

class _CategorySelectionSlideState extends State<CategorySelectionSlide> {
  @override
  void initState() {
    super.initState();

    // Post-frame callback to potentially skip directly to ResultsSlide
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isOnlyShowSelection = onlyShowSelectionAvailable(widget.filters, widget.adhesiveService);
      if (isOnlyShowSelection) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsSlide(
              filters: widget.filters,
              adhesiveService: widget.adhesiveService,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topIcons = generateTopIcons(widget.filters);
    final categories = widget.adhesiveService.buildCategories(widget.filters);

    // Convert categories into a list of data maps (label/iconPath/isDisabled)
    final gridItems = categories.map((category) {
      return {
        'label': category['label'] as String,
        'iconPath': category['iconPath'] as String,
        'isDisabled': false, // Set to true if certain conditions require disabling a button
      };
    }).toList();

    return BaseSlide(
      title: "Select Category",
      filters: widget.filters,
      adhesiveService: widget.adhesiveService,
      topRightButton: TopRightButton(
        filters: widget.filters,
        adhesiveService: widget.adhesiveService,
      ),
      topIcons: topIcons,
      onBackPressed: () {
        // Called when user taps the back button
        widget.filters.deselectLastFilter();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      // Pass raw button data
      customButtonData: gridItems,
      onItemTap: (label) {
        // If this is a "Show Selection" button and no category is selected, do nothing
        if (label == showSelectionButtonText && !isAnyCategorySelected(categories)) {
          return;
        }

        // If "Show Selection" button is tapped, go directly to ResultsSlide
        if (label == showSelectionButtonText) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsSlide(
                filters: widget.filters,
                adhesiveService: widget.adhesiveService,
              ),
            ),
          );
        } else {
          // Otherwise, navigate to CategoryDetailSlide
          try {
            final selectedCategory = categories.firstWhere((c) => c['label'] == label);

            final options = selectedCategory['options'] as List<String>;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailSlide(
                  filters: widget.filters,
                  adhesiveService: widget.adhesiveService,
                  title: "Select $label",
                  categoryType: label,
                  options: options,
                  previousCategorySlide: widget,
                ),
              ),
            );
          } catch (e) {
            print('Error: Category not found for label: $label');
            throw Exception('Category not found for label: $label');
          }
        }
      },
      gridColumns: 3, // Adjust as needed
    );
  }

  /// Determines if any category has been selected
  bool isAnyCategorySelected(List<Map<String, dynamic>> categories) {
    return categories.any((category) {
      final options = category['options'] as List;
      return options.isNotEmpty;
    });
  }
}
