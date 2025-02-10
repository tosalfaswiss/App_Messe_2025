import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../slides/industry_slide.dart';

class TopRightButton extends StatelessWidget {
  final Filters filters;
  final AdhesiveService adhesiveService;

  const TopRightButton({
    Key? key,
    required this.filters,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Reset filters and navigate back to IndustrySlide
        filters.reset();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => IndustrySlide(
              filters: filters,
              adhesiveService: adhesiveService,
            ),
          ),
          (route) => false,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Image.asset(
              _getIndustryIcon(filters.industry),
              height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.contain,   
            )   
            ),     
        ],
      ),
    );
  }

  String _getIndustryIcon(String? industry) {
    /*if (industry == "Mattress") return 'assets/mattress_icon.png';
    if (industry == "Upholstery") return 'assets/upholstery_icon.png';
    if (industry == "Automotive") return 'assets/automotive_icon.png';*/
    return 'assets/simalfa.png'; 
  }
}
