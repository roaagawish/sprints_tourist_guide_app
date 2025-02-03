import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/place_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ToggleFavouriteUsecase implements BaseUseCase<PlaceEntity, bool> {
  final Repository _repository;

  ToggleFavouriteUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([PlaceEntity? input]) async {
    return await _repository.toggleFavourite(input!);
  }
}
