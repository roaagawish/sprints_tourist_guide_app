import '../entities/place_entity.dart';
import '../repository/repository.dart';

class SuggestedPlacesUsecase {
  final Repository _repository;

  SuggestedPlacesUsecase(this._repository);

  Stream<List<PlaceEntity>> execute() {
    return _repository.getSuggestedPlaces();
  }
}
