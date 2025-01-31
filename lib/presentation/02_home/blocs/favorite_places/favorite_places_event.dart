part of 'favorite_places_bloc.dart';

@immutable
sealed class FavoritePlacesEvent {}

class LoadFavoritePlaces extends FavoritePlacesEvent {}
