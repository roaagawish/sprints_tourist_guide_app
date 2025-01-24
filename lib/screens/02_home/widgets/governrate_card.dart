import 'package:flutter/material.dart';
import '../../../app/functions.dart';
import '../../../models/governrate_model.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/routes_manager.dart';
import '../../../resourses/styles_manager.dart';

class GovernorateCard extends StatelessWidget {
  const GovernorateCard({
    super.key,
    required this.governorate,
  });

  final Governorate governorate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(governorate.governorateImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                ColorsManager.black.withValues(alpha: 0.5), BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(15),
          border: isLightTheme(context)
              ? Border.all(color: ColorsManager.black)
              : Border.all(color: ColorsManager.white),
          boxShadow: isLightTheme(context)
              ? [BoxShadow(color: ColorsManager.black, blurRadius: 6)]
              : [BoxShadow(color: ColorsManager.white, blurRadius: 6)],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Icon(Icons.location_on, color: Colors.white),
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.governmentDetailsRoute,
              arguments: governorate,
            );
          },
          title: Text(
            governorate.name,
            style: Styles.style24Bold().copyWith(
              color: Colors.white,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: governorate.landmarks.map((landmark) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '● ${landmark.name}',
                  style: Styles.style14Medium().copyWith(
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
