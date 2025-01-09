import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../resourses/assets_manager.dart';
import '../../../resourses/styles_manager.dart';

class EmptyFavoriteList extends StatelessWidget {
  const EmptyFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 30.0,
      children: [
        SizedBox(height: 30.0),
        Text(
          'You haven\'t added any favorite places yet!',
          style: Styles.style14Medium(),
        ),
        Lottie.asset(
          JsonAssets.empty,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
