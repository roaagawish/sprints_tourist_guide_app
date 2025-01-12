import 'package:easy_localization/easy_localization.dart';
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
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Image.asset(
                  place.image,
                  height: double.infinity,
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
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(place.name.tr(), style: Styles.style14Medium()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(place.governorate.tr(),
                      style: Styles.style12Medium()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
