import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../slides/industry_slide.dart';

class TopRightButton extends StatefulWidget {
  final AdhesiveService adhesiveService;

  const TopRightButton({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  State<TopRightButton> createState() => _TopRightButtonState();
}

class _TopRightButtonState extends State<TopRightButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final filters = context.read<Filters>();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(customButtonBorderRadius),
          splashColor: Colors.black12,
          hoverColor: Colors.transparent,
          onTap: () {
            filters.reset();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => IndustrySlide(
                  adhesiveService: widget.adhesiveService,
                ),
              ),
              (route) => false,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(customButtonBorderRadius),
              color: Colors.transparent,
            ),
            padding: const EdgeInsets.all(4.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Image.asset(
                topRightButtonIconPath,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
