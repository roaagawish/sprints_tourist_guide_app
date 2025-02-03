import '../entities/place_entity.dart';
import '../repository/repository.dart';

class FavouritePlacesUsecase {
  final Repository _repository;

  FavouritePlacesUsecase(this._repository);

  Stream<List<PlaceEntity>> execute() {
    return _repository.getFavouritePlaces();
  }
}
