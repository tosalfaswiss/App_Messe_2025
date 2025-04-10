import 'package:flutter/material.dart';
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
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _isHovered ? Colors.grey.shade100 : Colors.white,
                  border: Border.all(
                    color: customButtonBorderColor,
                    width: customButtonBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(customButtonBorderRadius),
                ),
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
                    const SizedBox(height: 6),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.iconData['label'],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
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
