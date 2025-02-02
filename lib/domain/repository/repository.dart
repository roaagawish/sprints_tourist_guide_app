import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../entities/auth_entity.dart';
import '../entities/otp_entity.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationEntity>> login(
      LoginRequest loginRequest);
  Future<Either<Failure, AuthenticationEntity>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, AuthenticationEntity>> updateInfo(
      UpdateInfoRequest updateInfoRequest);
  Future<Either<Failure, OtpEntity>> sendOtpToNewPhoneNumber(
      String newPhoneNumber);
  Either<Failure, PhoneAuthCredential> createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest);
}
