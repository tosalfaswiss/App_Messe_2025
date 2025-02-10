import 'package:flutter/material.dart';
import '../constants.dart';
import 'custom_button.dart';

class MiddleGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(String) onItemTap;
  final int? crossAxisCount;

  const MiddleGrid({
    Key? key,
    required this.items,
    required this.onItemTap,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen dimensions
    final double screenHeight = 0.6 * MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Adjust rows based on the number of items
    final int rows = items.length < 5 ? 1 : 2; // 1 row if less than 5 items, otherwise 2 rows

    // Calculate dynamic childAspectRatio
    final double gridHeight = screenHeight - gridMainAxisSpacing * (rows - 1);
    final double itemHeight = gridHeight / rows;
    final double itemWidth = screenWidth / (crossAxisCount ?? gridCrossAxisCount);
    final double aspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? gridCrossAxisCount,
        crossAxisSpacing: gridCrossAxisSpacing,
        mainAxisSpacing: gridMainAxisSpacing,
        childAspectRatio: aspectRatio, 
      ),
      padding: EdgeInsets.all(0.0), // Reduced padding for better spacing
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final String label = item['label'] ?? '';
        final String iconPath = item['iconPath'] ?? '';
        final bool isShowSelectionButton = label == showSelectionButtonText;

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
  }
}
