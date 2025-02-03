import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/di.dart';
import '../../../../domain/entities/place_entity.dart';
import '../../../../domain/usecase/favourite_places_usecase.dart';
import '../places_grid_view.dart';
import '../state_widgets/empty_state_widget.dart';
import '../state_widgets/error_state_widget.dart';

class FavoritePlaceStreamBuilder extends StatelessWidget {
  const FavoritePlaceStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final FavouritePlacesUsecase favouritePlacesUsecase = instance();
    return StreamBuilder<List<PlaceEntity>>(
      stream: favouritePlacesUsecase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.6,
            errorText: context
                .tr('failedToLoadPlaces', args: [snapshot.error.toString()]),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyStateWidget(label: context.tr('taps.emptyFav'));
        } else {
          return PlacesGridView(
            places: snapshot.data!,
          );
        }
      },
    );
  }
}
