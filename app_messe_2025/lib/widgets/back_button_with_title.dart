import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class BackButtonWithTitle extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const BackButtonWithTitle({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<BackButtonWithTitle> createState() => _BackButtonWithTitleState();
}

class _BackButtonWithTitleState extends State<BackButtonWithTitle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double dynamicFontSize = getTitleFontSize(context) * 0.5;
    final bool isExit = widget.title.toLowerCase() == "exit";

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: isExit ? () => SystemNavigator.pop() : widget.onPressed,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.grey.withOpacity(0.2),
        child: Transform.scale(
          scale: _isHovered ? 1.05 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: _isHovered
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isExit) ...[
                  Icon(
                    Icons.arrow_back,
                    color: titleTextColor,
                    size: dynamicFontSize * 0.8,
                  ),
                  const SizedBox(width: 12),
                ],
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.title,
                      style: titleTextStyle.copyWith(fontSize: dynamicFontSize),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
