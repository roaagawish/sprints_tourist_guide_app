import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sprints_tourist_guide_app/data/network/failure.dart';
import 'package:sprints_tourist_guide_app/domain/entities/place_entity.dart';
import 'package:sprints_tourist_guide_app/domain/usecase/toggle_favourite_usecase.dart';
import 'package:sprints_tourist_guide_app/presentation/02_home/blocs/like_unlike_cubit/like_unlike_cubit.dart';
import 'like_unlike_cubit_test.mocks.dart';

@GenerateMocks([ToggleFavouriteUsecase])
void main() {
  late LikeUnlikeCubit cubit;
  late MockToggleFavouriteUsecase mockToggleFavouriteUsecase;

  setUp(() {
    mockToggleFavouriteUsecase = MockToggleFavouriteUsecase();
    cubit = LikeUnlikeCubit(mockToggleFavouriteUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  final testPlace = PlaceEntity(
    id: '1',
    name: 'Test Place',
    governorate: 'Test Gov',
    description: 'Test Description',
    image: 'test_image_url',
    likes: [],
    lat: '0.0',
    lng: '0.0',
    popular: false,
  );

  group('LikeUnlikeCubit', () {
    test('initial state should be LikeUnlikeInitial', () {
      expect(cubit.state, isA<LikeUnlikeInitial>());
    });

    blocTest<LikeUnlikeCubit, LikeUnlikeState>(
      'emits [LikeUnlikeLoading, LikeUnlikeSuccess] when toggle is successful',
      build: () {
        when(mockToggleFavouriteUsecase.execute(any))
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.toggle(place: testPlace),
      expect: () => [
        LikeUnlikeLoading(),
        LikeUnlikeSuccess(),
      ],
      verify: (_) {
        verify(mockToggleFavouriteUsecase.execute(testPlace)).called(1);
      },
    );

    blocTest<LikeUnlikeCubit, LikeUnlikeState>(
      'emits [LikeUnlikeLoading, LikeUnlikeFailure] when toggle fails',
      build: () {
        when(mockToggleFavouriteUsecase.execute(any)).thenAnswer(
          (_) async => Left(Failure(500, "Server Error")),
        );
        return cubit;
      },
      act: (cubit) => cubit.toggle(place: testPlace),
      expect: () => [
        LikeUnlikeLoading(),
        LikeUnlikeFailure("Server Error 500"),
      ],
      verify: (_) {
        verify(mockToggleFavouriteUsecase.execute(testPlace)).called(1);
      },
    );
  });
}
