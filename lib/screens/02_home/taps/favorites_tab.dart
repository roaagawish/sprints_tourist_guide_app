import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resourses/language_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../providers/place_provider.dart';
import '../widgets/state_widgets/empty_state_widget.dart';
import '../widgets/places_grid_view.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
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
            child: placeProvider.favoritePlaces.isEmpty
                ? EmptyStateWidget(
                    label: tr("taps.emptyFav"),
                  )
                : PlacesGridView(
                    places: placeProvider.favoritePlaces,
                  ),
          ),
        ],
      ),
    );
  }
}
