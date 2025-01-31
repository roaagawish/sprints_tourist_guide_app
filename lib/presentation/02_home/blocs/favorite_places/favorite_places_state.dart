part of 'favorite_places_bloc.dart';

@immutable
sealed class FavoritePlacesState {
  final bool loading;
  final List<Place> items;

  const FavoritePlacesState(this.items, {required this.loading});
}

final class FavoritePlacesInitial extends FavoritePlacesState {
  const FavoritePlacesInitial(super.items, {required super.loading});
}

class FavoritePlacesLoading extends FavoritePlacesState {
  const FavoritePlacesLoading(super.items, {required super.loading});
}

class FavoritePlacesLoaded extends FavoritePlacesState {
  const FavoritePlacesLoaded(super.items, {required super.loading});
}

class FavoritePlacesEmpty extends FavoritePlacesState {
  const FavoritePlacesEmpty(super.items, {required super.loading});
}

class FavoritePlacesError extends FavoritePlacesState {
  final String message;

  const FavoritePlacesError(super.items,
      {required this.message, required super.loading});
}
