import 'package:flutter/material.dart';
import '../constants.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const HoverButton({required this.child, required this.onTap});

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(buttonBorderRadius),
            border: Border.all(color: titleBackgroundColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? hoverShadowColor.withOpacity(pressedShadowOpacity)
                    : _isHovered
                        ? hoverShadowColor.withOpacity(hoverShadowOpacity)
                        : hoverShadowColor.withOpacity(defaultShadowOpacity),
                spreadRadius: _isPressed ? 6 : (_isHovered ? 4 : 2),
                blurRadius: _isPressed ? 8 : (_isHovered ? 6 : 4),
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
