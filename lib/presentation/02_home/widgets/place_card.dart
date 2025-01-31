import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/styles_manager.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                place.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: place.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error, color: Colors.red),
                                Text(
                                  'Failed_to_load_image'.tr(),
                                  style: Styles.style14Medium(),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        PngAssets.cairo, //dummy img
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
                      //we deleted this provider,
                      //TODO: in the next firebase submit(add event in favoritePlacesBloc to like place)
                      //placeProvider.toggleFavorite(place);
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
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: Text(place.name, style: Styles.style14Medium()),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: Text(place.governorate, style: Styles.style12Medium()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
