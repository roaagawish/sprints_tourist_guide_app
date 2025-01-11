import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import 'place_card.dart';

class PlacesGridView extends StatelessWidget {
  final List<Place> places;
  const PlacesGridView({super.key, required this.places});

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
