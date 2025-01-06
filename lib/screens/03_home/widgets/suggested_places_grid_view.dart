import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';
import 'place_card.dart';

class SuggestedPlacesGridView extends StatelessWidget {
  const SuggestedPlacesGridView({super.key});

  // Sample data for places
  List<Place> get places => [
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
        // TODO Add more places as needed
      ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceCard(
          place: places[index],
        );
      },
    );
  }
}
