import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/assets_manager.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _suggestedPlaces = [
    Place(
      name: "place_provider.pyramidsofGiza",
      governorate: "place_provider.giza",
      image: PngAssets.pyramids,
    ),
    Place(
      name: "place_provider.luxorTemple",
      governorate: "place_provider.luxor",
      image: PngAssets.luxor,
    ),
    Place(
      name: "place_provider.pyramidsofGiza",
      governorate: "place_provider.giza",
      image: PngAssets.pyramids,
    ),
    Place(
      name: "place_provider.pyramidsofGiza",
      governorate: "place_provider.giza",
      image: PngAssets.pyramids,
    ),
  ];

  final List<Place> _popularPlaces = [
    Place(
      name: "place_provider.pyramidsofGiza",
      governorate: "place_provider.giza",
      image: PngAssets.pyramids,
    ),
    Place(
      name: "place_provider.luxorTemple",
      governorate: "place_provider.luxor",
      image: PngAssets.luxor,
    ),
    Place(
      name: "place_provider.luxorTemple",
      governorate: "place_provider.luxor",
      image: PngAssets.luxor,
    ),
    Place(
      name: "place_provider.luxorTemple",
      governorate: "place_provider.luxor",
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
