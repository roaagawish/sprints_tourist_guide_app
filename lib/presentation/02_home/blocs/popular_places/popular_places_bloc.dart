import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../../../../app/functions.dart';
import '../../../../domain/entities/place_model.dart';

part 'popular_places_event.dart';
part 'popular_places_state.dart';

class PopularPlacesBloc extends Bloc<PopularPlacesEvent, PopularPlacesState> {
  late List<Place> _placesList;
  bool maxReached = false;
  int _currentIndex = 0; // Tracks the current index for pagination
  static const int _itemsPerPage = 5; // Number of items to load per page

  PopularPlacesBloc() : super(PopularPlacesInitial([], loading: false)) {
    // Initialize _placesList in the constructor body to use Skeletonizer appropriately
    _placesList = generateDummyPlacesList();
    // Event handler for loading places
    on<LoadPopularPlaces>(_onLoadPlaces);
    // Event handler for loading more places
    on<LoadMorePopularPlaces>(_onLoadMorePlaces);
  }

  Future<void> _onLoadPlaces(
      LoadPopularPlaces event, Emitter<PopularPlacesState> emit) async {
    emit(PopularPlacesLoading(_placesList, loading: true));
    try {
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 5));
      // Load data from JSON
      final String response = await rootBundle
          .loadString('assets/json/popular_places.json', cache: false);
      final data = json.decode(response);
      //set actual data
      List<Place> allData = (data['popularPlaces'] as List)
          .map((place) => Place.fromJson(place))
          .toList();
      // Load the first 5 items
      _placesList = allData.take(_itemsPerPage).toList();
      _currentIndex = _placesList.length;
      //if nothing went wrong emit loaded state :)
      emit(PopularPlacesLoaded(
        _placesList,
        loading: false,
      ));
    } catch (e) {
      emit(PopularPlacesError(_placesList,
          message: tr('failedToLoadPlaces', args: [e.toString()]),
          loading: false));
    }
  }

  Future<void> _onLoadMorePlaces(
      LoadMorePopularPlaces event, Emitter<PopularPlacesState> emit) async {
    if (maxReached) {
      //to prevent useless Api calls
      return;
    }
    if (state is PopularPlacesLoaded) {
      final currentState = state as PopularPlacesLoaded;
      // emit loading for loading more items
      emit(PopularPlacesLoading(_placesList, loading: false));
      try {
        // Simulate a delay as if we call an Api :)
        await Future.delayed(const Duration(seconds: 5));
        // Load data from JSON
        final String response = await rootBundle
            .loadString('assets/json/popular_places.json', cache: false);
        final data = json.decode(response);
        //set actual data
        List<Place> allData = (data['popularPlaces'] as List)
            .map((place) => Place.fromJson(place))
            .toList();
        // Check if more items are available
        if (_currentIndex < allData.length) {
          var nextIndex = _currentIndex + _itemsPerPage;
          int end;
          if (nextIndex > allData.length) {
            end = allData.length;
            maxReached = true;
          } else {
            end = nextIndex;
          }
          final moreItems = allData.sublist(
            _currentIndex,
            end,
          );
          _currentIndex += moreItems.length;
          // add more items then emit loaded state
          emit(PopularPlacesLoaded(
            currentState.items + moreItems,
            loading: false,
          ));
        } else {
          // No more items to load
          emit(currentState);
        }
      } catch (e) {
        emit(PopularPlacesError(_placesList,
            message: tr('failedToLoadPlaces', args: [e.toString()]),
            loading: false));
      }
    }
  }
}
