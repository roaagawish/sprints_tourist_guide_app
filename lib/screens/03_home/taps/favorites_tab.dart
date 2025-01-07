import 'package:flutter/material.dart';

import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../widgets/places_grid_view.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  // Sample data for places
  // or coming from api
  List<Place> get favoritePlaces => [
        Place(
          name: 'Pyramids of Giza',
          governorate: 'Giza',
          image: PngAssets.pyramids,
          isFavorite: true,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: PngAssets.luxor,
        ),
        Place(
          name: 'Pyramids of Giza',
          governorate: 'Giza',
          image: PngAssets.pyramids,
          isFavorite: true,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: PngAssets.luxor,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: PngAssets.luxor,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: PngAssets.luxor,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: PngAssets.luxor,
        ),
        // TODO Add more places as needed
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Text(
            'Your Favorite Places',
            style: Styles.style20Bold(),
          ),
          Expanded(
            flex: 3,
            child: PlacesGridView(
              places: favoritePlaces,
            ),
          ),
        ],
      ),
    );
  }
}
