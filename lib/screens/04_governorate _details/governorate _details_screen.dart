import 'package:flutter/material.dart';
import '../../models/governrate_model.dart';
import 'widgets/landmark_card.dart';

class GovernorateDetailsScreen extends StatelessWidget {
  final Governorate governorate;
  const GovernorateDetailsScreen({super.key, required this.governorate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(governorate.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView.separated(
          itemCount: governorate.landmarks.length,
          itemBuilder: (context, index) {
            return LandmarkCard(landmark: governorate.landmarks[index]);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
