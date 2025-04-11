import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class ExitButton extends StatefulWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(customButtonBorderRadius),
          ),
          splashColor: Colors.black12,
          hoverColor: Colors.transparent,
          onTap: () {
            // Exit the app. (Use this with caution—platform guidelines may differ.)
            SystemNavigator.pop();
          },
          child: Transform.scale(
            scale: _isHovered ? 1.05 : 1.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.exit_to_app,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
