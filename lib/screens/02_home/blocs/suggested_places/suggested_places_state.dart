part of 'suggested_places_bloc.dart';

@immutable
sealed class SuggestedPlacesState {
  final bool loading;
  final List<Place> items;

  const SuggestedPlacesState(this.items, {required this.loading});
}

final class SuggestedPlacesInitial extends SuggestedPlacesState {
  const SuggestedPlacesInitial(super.items, {required super.loading});
}

class SuggestedPlacesLoading extends SuggestedPlacesState {
  const SuggestedPlacesLoading(super.items, {required super.loading});
}

class SuggestedPlacesLoaded extends SuggestedPlacesState {
  const SuggestedPlacesLoaded(super.items, {required super.loading});
}

class SuggestedPlacesError extends SuggestedPlacesState {
  final String message;

  const SuggestedPlacesError(super.items,
      {required this.message, required super.loading});
}
