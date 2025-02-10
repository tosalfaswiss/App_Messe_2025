import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../constants.dart'; 

class TopIconsButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height * 0.2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => handleTopIconClick(context, iconData, filters, adhesiveService, previousCategorySlide),
        child: Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
          border: Border.all(color: customButtonBorderColor, width: customButtonBorderWidth),
          borderRadius: BorderRadius.circular(customButtonBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                iconData['label'],
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
