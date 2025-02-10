import 'package:flutter/material.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final bool isDisabled;
  final int itemCount;

  const CustomButton({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.borderColor = customButtonBorderColor,
    this.backgroundColor = customButtonBackgroundColor,
    this.textStyle = customButtonTextStyle,
    this.isDisabled = false,
    this.itemCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine effective styles based on disabled state
    final Color effectiveBorderColor = isDisabled ? Colors.grey : borderColor;
    final Color effectiveBackgroundColor = isDisabled ? Colors.grey[300]! : backgroundColor;
    final TextStyle effectiveTextStyle = isDisabled
        ? textStyle.copyWith(color: Colors.grey)
        : textStyle;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: customButtonSize * 0.2 * MediaQuery.of(context).size.width, // Reverted width
        decoration: BoxDecoration(
          border: Border.all(color: effectiveBorderColor, width: customButtonBorderWidth),
          borderRadius: BorderRadius.circular(customButtonBorderRadius),
          color: effectiveBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: customButtonShadowColor,
              blurRadius: customButtonShadowBlurRadius,
              offset: customButtonShadowOffset,
            ),
          ],
        ),
        child: Center( // Center everything within the container
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to center content
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              SizedBox(
                width: customButtonSize * MediaQuery.of(context).size.width / 2, // Reverted width
                height: itemCount < 5
                    ? customButtonSize * MediaQuery.of(context).size.height // Reverted height
                    : customButtonSize * MediaQuery.of(context).size.height / 2,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Spacer for better alignment
              Text(
                text,
                style: effectiveTextStyle.copyWith(
                  fontSize: customButtonSize * 192, // Reverted font size logic
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
