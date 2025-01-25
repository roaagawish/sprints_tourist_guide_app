part of 'popular_places_bloc.dart';

@immutable
sealed class PopularPlacesEvent {}

class LoadPopularPlaces extends PopularPlacesEvent {}

class LoadMorePopularPlaces extends PopularPlacesEvent {}
