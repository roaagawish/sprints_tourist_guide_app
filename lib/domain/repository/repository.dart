import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../entities/auth_entity.dart';
import '../entities/otp_entity.dart';
import '../entities/place_entity.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationEntity>> login(
      LoginRequest loginRequest);
  Future<Either<Failure, AuthenticationEntity>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, AuthenticationEntity>> updateInfo(
      UpdateInfoRequest updateInfoRequest);
  Stream<List<PlaceEntity>> getSuggestedPlaces();
  Stream<List<PlaceEntity>> getPopularPlaces();
  Stream<List<PlaceEntity>> getFavouritePlaces();
  Future<Either<Failure, bool>> toggleFavourite(PlaceEntity place);
  //these two functions are not used due to billing setup on firebase :(
  Future<Either<Failure, OtpEntity>> sendOtpToNewPhoneNumber(
      String newPhoneNumber);
  Either<Failure, PhoneAuthCredential> createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest);
}
