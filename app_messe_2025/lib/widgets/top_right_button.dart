import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/filters.dart';
import '../services/adhesive_service.dart';
import '../slides/industry_slide.dart';

class TopRightButton extends StatelessWidget {
  final AdhesiveService adhesiveService;

  const TopRightButton({
    Key? key,
    required this.adhesiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = context.read<Filters>();

    return GestureDetector(
      onTap: () {
        // Reset filters and navigate back to IndustrySlide
        filters.reset();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => IndustrySlide(
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
            ),
          ),
        ],
      ),
    );
  }

  String _getIndustryIcon(String? industry) {
    // Optional: Use dynamic icon loading based on filter if needed
    return 'assets/simalfa.png';
  }
}
