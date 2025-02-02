import 'package:dartz/dartz.dart';
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart';
import '../../app/app_prefs.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  RepositoryImpl(this._remoteDataSource, this._networkInfo,
      this._localDataSource, this._appPreferences);

  @override
  Future<Either<Failure, AuthenticationEntity>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final AuthenticationEntity authenticationEntity =
            await _remoteDataSource.login(loginRequest);
        await _localDataSource.saveUserDataToCache(authenticationEntity);
        await _appPreferences.setUserLoggedIn();
        return Right(authenticationEntity);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final AuthenticationEntity authenticationEntity =
            await _remoteDataSource.register(registerRequest);
        await _localDataSource.saveUserDataToCache(authenticationEntity);
        await _appPreferences.setUserLoggedIn();
        return Right(authenticationEntity);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.logout();
        await _localDataSource.clearAllCachedBoxes();
        await _appPreferences.removePrefs();
        return const Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> updateInfo(
      UpdateInfoRequest updateInfoRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final AuthenticationEntity authenticationEntity =
            await _remoteDataSource.updateInfo(updateInfoRequest);
        await _localDataSource.updateUserDataInCache(updateInfoRequest);
        return Right(authenticationEntity);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, OtpEntity>> sendOtpToNewPhoneNumber(
      String newPhoneNumber) async {
    if (await _networkInfo.isConnected) {
      try {
        final OtpEntity otpEntity =
            await _remoteDataSource.sendOtpToNewPhoneNumber(newPhoneNumber);
        return Right(otpEntity);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Either<Failure, PhoneAuthCredential> createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest) {
    try {
      final PhoneAuthCredential phoneAuthCredential = _remoteDataSource
          .createPhoneAuthCredentialWithOtp(phoneAuthCredentialRequest);
      return Right(phoneAuthCredential);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
