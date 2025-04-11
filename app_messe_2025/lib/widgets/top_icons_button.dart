import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../utils/utils.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart';

class TopIconsButton extends StatefulWidget {
  final String imagePath;
  final Map<String, dynamic> iconData;
  final Filters filters;
  final AdhesiveService adhesiveService;
  final Widget previousCategorySlide;

  const TopIconsButton({
    Key? key,
    required this.imagePath,
    required this.iconData,
    required this.filters,
    required this.adhesiveService,
    required this.previousCategorySlide,
  }) : super(key: key);

  @override
  State<TopIconsButton> createState() => _TopIconsButtonState();
}

class _TopIconsButtonState extends State<TopIconsButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double maxSize = MediaQuery.of(context).size.height * 0.2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: SizedBox(
          width: maxSize,
          height: maxSize,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(customButtonBorderRadius),
              onTap: () => handleTopIconClick(
                context,
                widget.iconData,
                widget.filters,
                widget.adhesiveService,
                widget.previousCategorySlide,
              ),
              splashColor: Colors.black12,
              hoverColor: Colors.transparent,
              child: Transform.scale(
                scale: _isHovered ? 1.05 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white, // Base background color
                    border: Border.all(
                      color: _isHovered
                          ? const Color(0xFF938B33) // Chosen darker green on hover
                          : customButtonBorderColor,
                      width: customButtonBorderWidth * 0.67,
                    ),
                    borderRadius:
                        BorderRadius.circular(customButtonBorderRadius),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  widget.imagePath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        widget.imagePath,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.001,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.001,
                                  left: MediaQuery.of(context).size.width *
                                      0.001,
                                  right: MediaQuery.of(context).size.width *
                                      0.001,
                                ),
                                child: AutoSizeText(
                                  widget.iconData['label'],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  minFontSize: 8,
                                  maxFontSize: 20,
                                  stepGranularity: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Semi-transparent overlay on hover
                      if (_isHovered)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  customButtonBorderRadius),
                              color: Colors.grey.shade200.withOpacity(0.2),
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
      ),
    );
  }
}
