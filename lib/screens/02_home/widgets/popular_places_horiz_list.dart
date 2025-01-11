import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import 'place_card.dart';

class PopularPlacesHorizontalList extends StatelessWidget {
  const PopularPlacesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: placeProvider.popularPlaces.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 200,
            child: PlaceCard(
              place: placeProvider.popularPlaces[index],
            ),
          ),
        );
      },
    );
  }
}
