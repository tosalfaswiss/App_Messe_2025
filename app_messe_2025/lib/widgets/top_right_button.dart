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
      child: Align(
        alignment: Alignment.centerRight,
        // Constrain the clickable area to just the image's size.
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            // This customBorder confines the splash to the image's rounded shape.
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(customButtonBorderRadius),
            ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(customButtonBorderRadius),
              child: Stack(
                alignment: Alignment.center,
                // The Stack sizes itself to the image.
                children: [
                  Image.asset(
                    topRightButtonIconPath,
                    height: MediaQuery.of(context).size.height * 0.2,
                    fit: BoxFit.contain,
                  ),
                  // The hover overlay only covers the image.
                  if (_isHovered)
                    Positioned.fill(
                      child: Container(
                        color: Colors.grey.shade200.withOpacity(0.3),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
