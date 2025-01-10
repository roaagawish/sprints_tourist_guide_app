import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _suggestedPlaces = [
    Place(
      name: 'Pyramids of Giza',
      governorate: 'Giza',
      image: PngAssets.pyramids,
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
    ),
    Place(
      name: 'Pyramids of Giza',
      governorate: 'Giza',
      image: PngAssets.pyramids,
    ),
  ];

  final List<Place> _popularPlaces = [
    Place(
      name: 'Pyramids of Giza',
      governorate: 'Giza',
      image: PngAssets.pyramids,
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
