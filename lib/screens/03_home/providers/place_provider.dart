import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _suggestedPlaces = [
    Place(
      name: tr("place_provider.pyramidsofGiza"),
      governorate: tr("place_provider.giza"),
      image: PngAssets.pyramids,
    ),
    Place(
      name: tr("place_provider.luxorTemple"),
      governorate: tr("place_provider.luxor"),
      image: PngAssets.luxor,
    ),
    Place(
      name:tr("place_provider.pyramidsofGiza"),
      governorate: tr("place_provider.giza"),
      image: PngAssets.pyramids,
    ),
    Place(
      name: tr("place_provider.pyramidsofGiza"),
      governorate: tr("place_provider.giza"),
      image: PngAssets.pyramids,
    ),
  ];

  final List<Place> _popularPlaces = [
    Place(
      name: tr("place_provider.pyramidsofGiza"),
      governorate: tr("place_provider.giza"),
      image: PngAssets.pyramids,
    ),
    Place(
      name:tr("place_provider.luxorTemple"),
      governorate: tr("place_provider.luxor"),
      image: PngAssets.luxor,
    ),
    Place(
      name: tr("place_provider.luxorTemple"),
      governorate:tr("place_provider.luxor"),
      image: PngAssets.luxor,
    ),
    Place(
      name: tr("place_provider.luxorTemple"),
      governorate:tr("place_provider.luxor"),
      image: PngAssets.luxor,
    ),
  ];

  List<Place> get suggestedPlaces => _suggestedPlaces;
  List<Place> get popularPlaces => _popularPlaces;

  List<Place> get favoritePlaces => {..._suggestedPlaces, ..._popularPlaces}
      .where((place) => place.isFavorite)
      .toList();

  void toggleFavorite(Place place) {
    place.isFavorite = !place.isFavorite;
    notifyListeners();
  }
}
