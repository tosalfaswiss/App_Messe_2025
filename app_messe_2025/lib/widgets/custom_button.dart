import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../constants.dart';

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        widget.isDisabled ? Colors.grey : widget.borderColor;

    final Color effectiveBackgroundColor = widget.isDisabled
        ? Colors.grey[300]!
        : widget.backgroundColor;

    final TextStyle effectiveTextStyle = widget.isDisabled
        ? widget.textStyle.copyWith(color: Colors.grey)
        : widget.textStyle;

    final double buttonWidth =
        customButtonSize * 0.2 * MediaQuery.of(context).size.width;

    final double imageHeight = widget.itemCount < 5
        ? customButtonSize * MediaQuery.of(context).size.height
        : customButtonSize * MediaQuery.of(context).size.height * 0.5;

    final double spacingAboveText = widget.itemCount < 5
        ? MediaQuery.of(context).size.height * 0.02
        : MediaQuery.of(context).size.height * 0.01;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: buttonWidth,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(customButtonBorderRadius),
            onTap: widget.isDisabled ? null : widget.onTap,
            splashColor: Colors.black12,
            hoverColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: effectiveBorderColor,
                  width: customButtonBorderWidth,
                ),
                borderRadius:
                    BorderRadius.circular(customButtonBorderRadius),
                color: _isHovered
                    ? Colors.grey.shade100
                    : effectiveBackgroundColor,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: customButtonSize *
                          MediaQuery.of(context).size.width / 2,
                      height: imageHeight,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: FittedBox(
                              child: Text(
                                widget.imagePath,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: spacingAboveText, // Dynamically smaller for many items
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AutoSizeText(
                        widget.text,
                        style: effectiveTextStyle,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        minFontSize: 8,
                        maxFontSize: 32,
                        stepGranularity: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
