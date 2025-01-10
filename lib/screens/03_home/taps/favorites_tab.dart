import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resourses/styles_manager.dart';
import '../providers/place_provider.dart';
import '../widgets/empty_favorite_list.dart';
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
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Favorite Places',
              style: Styles.style20Bold(),
            ),
          ),
          Expanded(
            flex: 3,
            child: placeProvider.favoritePlaces.isEmpty
                ? EmptyFavoriteList()
                : PlacesGridView(
                    places: placeProvider.favoritePlaces,
                  ),
          ),
        ],
      ),
    );
  }
}
