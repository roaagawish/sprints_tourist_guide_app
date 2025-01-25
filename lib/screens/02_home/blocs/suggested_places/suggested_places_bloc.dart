import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../../../../app/functions.dart';
import '../../../../models/place_model.dart';

part 'suggested_places_event.dart';
part 'suggested_places_state.dart';

class SuggestedPlacesBloc
    extends Bloc<SuggestedPlacesEvent, SuggestedPlacesState> {
  late List<Place> _placesList;

  SuggestedPlacesBloc() : super(SuggestedPlacesInitial([], loading: false)) {
    // Initialize _placesList in the constructor body to use Skeletonizer appropriately
    _placesList = generateDummyPlacesList();
    // Event handler for loading places
    on<LoadSuggestedPlaces>(_onLoadPlaces);
  }

  Future<void> _onLoadPlaces(
      LoadSuggestedPlaces event, Emitter<SuggestedPlacesState> emit) async {
    emit(SuggestedPlacesLoading(_placesList, loading: true));
    try {
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 5));
      // Load data from JSON
      final String response = await rootBundle
          .loadString('assets/json/suggested_places.json', cache: false);
      final data = json.decode(response);
      //set actual data
      _placesList = (data['suggestedPlaces'] as List)
          .map((place) => Place.fromJson(place))
          .toList();
      //if nothing went wrong emit loaded state :)
      emit(SuggestedPlacesLoaded(
        _placesList,
        loading: false,
      ));
    } catch (e) {
      emit(SuggestedPlacesError(_placesList,
          message: 'Failed to load places: $e', loading: false));
    }
  }
}
