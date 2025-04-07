import 'package:flutter/material.dart';
import '../constants.dart';
import 'custom_button.dart';

class MiddleGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(String) onItemTap;
  final int? crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const MiddleGrid({
    Key? key,
    required this.items,
    required this.onItemTap,
    this.crossAxisCount,
    this.crossAxisSpacing = 20.0,
    this.mainAxisSpacing = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int rows = items.length < 5 ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double gridHeight = constraints.maxHeight - mainAxisSpacing * (rows - 1);
        final double itemHeight = gridHeight / rows;
        final double itemWidth = constraints.maxWidth / (crossAxisCount ?? gridCrossAxisCount);
        final double aspectRatio = itemWidth / itemHeight;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount ?? gridCrossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: aspectRatio,
          ),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final String label = item['label'] ?? '';
            final String iconPath = item['iconPath'] ?? '';

            return CustomButton(
              imagePath: iconPath,
              text: label,
              itemCount: items.length,
              onTap: () {
                if (item['isDisabled'] != true) {
                  onItemTap(label);
                }
              },
              borderColor: (label == 'Deselect' || label == 'Show Selection')
                  ? showSelectionButtonBorderColor
                  : (item['isDisabled'] == true ? Colors.grey : customButtonBorderColor),
              backgroundColor: item['isDisabled'] == true ? Colors.grey[300]! : customButtonBackgroundColor,
              textStyle: item['isDisabled'] == true
                  ? customButtonTextStyle.copyWith(color: Colors.grey)
                  : customButtonTextStyle,
              isDisabled: item['isDisabled'] ?? false,
            );
          },
        );
      },
    );
  }
}
