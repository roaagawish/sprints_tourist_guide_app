import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/styles_manager.dart';
import '../widgets/bloc_builders/favorite_places_bloc_builder.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.0,
        children: [
          Align(
            alignment: LocalizationUtils.isCurrentLocalAr(context)
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              tr("taps.favTitle"),
              style: Styles.style20Bold(),
            ),
          ),
          Expanded(
            flex: 3,
            child: FavoritePlacesBlocBuilder(),
          ),
        ],
      ),
    );
  }
}
