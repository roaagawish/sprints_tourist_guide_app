part of 'like_unlike_cubit.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}

final class LikeUnlikeLoading extends LikeUnlikeState {}

final class LikeUnlikeSuccess extends LikeUnlikeState {}

final class LikeUnlikeFailure extends LikeUnlikeState {
  final String errMessage;

  LikeUnlikeFailure(this.errMessage);
}
