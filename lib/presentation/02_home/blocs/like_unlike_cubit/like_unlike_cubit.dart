import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../domain/entities/place_entity.dart';
import '../../../../domain/usecase/toggle_favourite_usecase.dart';

part 'like_unlike_state.dart';

class LikeUnlikeCubit extends Cubit<LikeUnlikeState> {
  final ToggleFavouriteUsecase _toggleFavouriteUsecase;
  LikeUnlikeCubit(this._toggleFavouriteUsecase) : super(LikeUnlikeInitial());

  Future<void> toggle({required PlaceEntity place}) async {
    emit(LikeUnlikeLoading());
    var result = await _toggleFavouriteUsecase.execute(place);
    result.fold((failure) async {
      var errMessage =
          '${failure.message.toString()} ${failure.code.toString()}';
      emit(LikeUnlikeFailure(errMessage));
    }, (isSuccess) async {
      emit(LikeUnlikeSuccess());
    });
  }
}
