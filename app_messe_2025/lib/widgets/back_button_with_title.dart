import 'package:flutter/material.dart';
import '../constants.dart';

class BackButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BackButtonWithTitle({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dynamicFontSize = getTitleFontSize(context) * 0.5;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              color: titleTextColor,
              size: dynamicFontSize * 0.8,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: titleTextStyle.copyWith(fontSize: dynamicFontSize),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
