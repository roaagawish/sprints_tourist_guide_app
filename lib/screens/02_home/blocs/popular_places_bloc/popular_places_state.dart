part of 'popular_places_bloc.dart';

@immutable
sealed class PopularPlacesState {
  final bool loading;
  final List<Place> items;

  const PopularPlacesState(this.items, {required this.loading});
}

final class PopularPlacesInitial extends PopularPlacesState {
  const PopularPlacesInitial(super.items, {required super.loading});
}

class PopularPlacesLoading extends PopularPlacesState {
  const PopularPlacesLoading(super.items, {required super.loading});
}

class PopularPlacesLoaded extends PopularPlacesState {
  const PopularPlacesLoaded(super.items, {required super.loading});
}

class PopularPlacesError extends PopularPlacesState {
  final String message;

  const PopularPlacesError(super.items,
      {required this.message, required super.loading});
}
