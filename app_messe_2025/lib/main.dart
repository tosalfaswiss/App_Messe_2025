import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'slides/industry_slide.dart';
import 'models/filters.dart';
import 'services/adhesive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final adhesiveService = AdhesiveService();
  await adhesiveService.loadData();

  runApp(
    ChangeNotifierProvider(
      create: (_) => Filters(),
      child: MyApp(adhesiveService: adhesiveService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdhesiveService adhesiveService;

  const MyApp({required this.adhesiveService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndustrySlide(
        adhesiveService: adhesiveService,
      ),
    );
  }
}
