import '../entities/place_entity.dart';
import '../repository/repository.dart';

class PopularPlacesUsecase {
  final Repository _repository;

  PopularPlacesUsecase(this._repository);

  Stream<List<PlaceEntity>> execute() {
    return _repository.getPopularPlaces();
  }
}
