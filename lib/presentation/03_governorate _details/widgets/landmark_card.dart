import 'package:flutter/material.dart';
import '../../../app/functions.dart';
import '../../../domain/entities/governrate_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/styles_manager.dart';

class LandmarkCard extends StatelessWidget {
  const LandmarkCard({
    super.key,
    required this.landmark,
  });

  final Landmark landmark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: 16.0,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(landmark.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    ColorsManager.black.withValues(alpha: 0.5),
                    BlendMode.darken),
              ),
              boxShadow: [BoxShadow(color: ColorsManager.black, blurRadius: 6)],
            ),
            child: Align(
              alignment: LocalizationUtils.isCurrentLocalAr(context)
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: Text(
                landmark.name,
                style: Styles.style24Bold().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          RichText(
              text: TextSpan(
            text: landmark.description,
            style: Styles.style14Medium().copyWith(
                color: isLightTheme(context)
                    ? ColorsManager.black
                    : ColorsManager.white),
          )),
        ],
      ),
    );
  }
}
