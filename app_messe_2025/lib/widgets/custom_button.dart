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

    final double spacingAboveText = MediaQuery.of(context).size.height * 0.02;

    return MouseRegion(
      onEnter: (_) {
        if (!widget.isDisabled) {
          setState(() {
            _isHovered = true;
          });
        }
      },
      onExit: (_) {
        if (!widget.isDisabled) {
          setState(() {
            _isHovered = false;
          });
        }
      },
      child: SizedBox(
        width: buttonWidth,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(customButtonBorderRadius),
            onTap: widget.isDisabled ? null : widget.onTap,
            splashColor: Colors.black12,
            hoverColor: Colors.transparent,
            child: Transform.scale(
              scale: _isHovered ? 1.05 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  border: Border.all(
                    // Use a darker green version of Color(0xFFAC9E00)
                    color: _isHovered ? const Color(0xFF938B33) : effectiveBorderColor,
                    width: customButtonBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(customButtonBorderRadius),
                  color: effectiveBackgroundColor,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: widget.itemCount > 4
                            ? MediaQuery.of(context).size.height * 0.025
                            : MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.015,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: customButtonSize *
                                MediaQuery.of(context).size.width /
                                2,
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
                            height: spacingAboveText,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.015 *
                                    MediaQuery.of(context).size.width,
                              ),
                              child: AutoSizeText(
                                widget.text,
                                style: effectiveTextStyle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                minFontSize: 4,
                                maxFontSize: 32,
                                stepGranularity: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Semi-transparent overlay for hover effect.
                    if (_isHovered)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(customButtonBorderRadius),
                            color: Colors.grey.shade300.withOpacity(0.2),
                          ),
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
