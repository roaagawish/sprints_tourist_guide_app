import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/governrate_model.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

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
             alignment:context.locale.languageCode == "ar" ? Alignment.bottomRight : Alignment.bottomLeft,
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
            style: Styles.style14Medium(),
          )),
        ],
      ),
    );
  }
}
