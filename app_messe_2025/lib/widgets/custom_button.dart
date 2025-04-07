import 'package:flutter/material.dart';
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
                    : effectiveBackgroundColor, // ✅ hover background
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: customButtonSize *
                          MediaQuery.of(context).size.width /
                          2,
                      height: widget.itemCount < 5
                          ? customButtonSize *
                              MediaQuery.of(context).size.height
                          : customButtonSize *
                              MediaQuery.of(context).size.height /
                              2,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      widget.text,
                      style: effectiveTextStyle.copyWith(
                        fontSize: customButtonSize * 192,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
