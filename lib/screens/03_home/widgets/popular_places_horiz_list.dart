import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';
import 'place_card.dart';

class PopularPlacesHorizontalList extends StatelessWidget {
  const PopularPlacesHorizontalList({super.key});

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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 200,
            child: PlaceCard(
              place: places[index],
            ),
          ),
        );
      },
    );
  }
}
