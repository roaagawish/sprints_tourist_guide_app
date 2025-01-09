import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/place_model.dart';
import '../../../resourses/styles_manager.dart';
import '../providers/place_provider.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                place.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    place.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    placeProvider.toggleFavorite(place);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(place.name, style: Styles.style14Medium()),
                Text(place.governorate, style: Styles.style12Medium()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
