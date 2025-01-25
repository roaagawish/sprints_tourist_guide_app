import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'suggested_places_event.dart';
part 'suggested_places_state.dart';

class SuggestedPlacesBloc extends Bloc<SuggestedPlacesEvent, SuggestedPlacesState> {
  SuggestedPlacesBloc() : super(SuggestedPlacesInitial()) {
    on<SuggestedPlacesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
