import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resourses/language_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../providers/place_provider.dart';
import '../widgets/bloc_builders/popular_places_bloc_builder.dart';
import '../widgets/places_grid_view.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Padding(
      padding: LocalizationUtils.isCurrentLocalAr(context)
          ? const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0)
          : const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Text(
            context.tr("taps.homePopelarPlaces"),
            style: Styles.style20Bold(),
          ),
          Expanded(
            flex: 2,
            child: PopularPlacesBlocBuilder(),
          ),
          Text(
            context.tr("taps.homeSuggestedPlaces"),
            style: Styles.style20Bold(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: LocalizationUtils.isCurrentLocalAr(context)
                  ? const EdgeInsets.only(left: 16.0)
                  : const EdgeInsets.only(right: 16.0),
              child: PlacesGridView(
                places: placeProvider.suggestedPlaces,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
