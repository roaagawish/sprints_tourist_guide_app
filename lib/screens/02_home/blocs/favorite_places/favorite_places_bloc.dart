import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../../../../app/functions.dart';
import '../../../../models/place_model.dart';

part 'favorite_places_event.dart';
part 'favorite_places_state.dart';

class FavoritePlacesBloc
    extends Bloc<FavoritePlacesEvent, FavoritePlacesState> {
  late List<Place> _placesList;

  FavoritePlacesBloc() : super(FavoritePlacesInitial([], loading: false)) {
    // Initialize _placesList in the constructor body to use Skeletonizer appropriately
    _placesList = generateDummyPlacesList();
    // Event handler for loading places
    on<LoadFavoritePlaces>(_onLoadPlaces);
  }

  Future<void> _onLoadPlaces(
      LoadFavoritePlaces event, Emitter<FavoritePlacesState> emit) async {
    emit(FavoritePlacesLoading(_placesList, loading: true));
    try {
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 5));
      // Load data from JSON
      final String response = await rootBundle
          .loadString('assets/json/favorite_places.json', cache: false);
      final data = json.decode(response);
      //set actual data
      _placesList = (data['FavoritePlaces'] as List)
          .map((place) => Place.fromJson(place))
          .toList();

      if (_placesList.isNotEmpty) {
        emit(FavoritePlacesLoaded(_placesList, loading: false));
      } else {
        emit(FavoritePlacesEmpty(_placesList, loading: false));
      }
    } catch (e) {
      emit(FavoritePlacesError(_placesList,
          message: tr('failedToLoadPlaces', args: [e.toString()]),
          loading: false));
    }
  }
}
