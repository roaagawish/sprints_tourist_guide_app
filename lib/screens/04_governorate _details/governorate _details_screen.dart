import 'package:flutter/material.dart';
import '../../models/governrate_model.dart';

class GovernorateDetailsScreen extends StatelessWidget {
  final Governorate governorate;
  const GovernorateDetailsScreen({super.key, required this.governorate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(governorate.name),
      ),
      body: const Center(
        child: Text('Government Details Screen'),
      ),
    );
  }
}
