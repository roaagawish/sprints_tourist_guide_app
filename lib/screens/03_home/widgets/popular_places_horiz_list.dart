import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import 'place_card.dart';

class PopularPlacesHorizontalList extends StatelessWidget {
  const PopularPlacesHorizontalList({super.key});

  // Sample data for places
  List<Place> get places => [
        Place(
          name: 'Pyramids of Giza',
          governorate: 'Giza',
          image: 'assets/png/pyramids.png',
          isFavorite: true,
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: 'assets/png/luxor.png',
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: 'assets/png/luxor.png',
        ),
        Place(
          name: 'Luxor Temple',
          governorate: 'Luxor',
          image: 'assets/png/luxor.png',
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
