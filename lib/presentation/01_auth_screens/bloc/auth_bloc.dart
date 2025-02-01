import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../app/di.dart';
import '../../../data/data_source/local_data_source.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../../domain/entities/otp_entity.dart';
import '../../../domain/usecase/create_phone_auth_from_otp_usecase.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../../domain/usecase/send_phone_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUsecase _registerUseCase;
  final LogoutUsecase _logoutUseCase;
  final SendPhoneOtpUsecase _sendPhoneOtpUsecase;
  final CreatePhoneAuthFromOtpUsecase _createPhoneAuthFromOtpUsecase;

  final LocalDataSource _localDataSource = instance();

  AuthenticationEntity? _authObj;
  String? _errMessage;

  AuthenticationEntity? get authObj => _authObj;

  AuthBloc(this._loginUseCase, this._registerUseCase, this._logoutUseCase,
      this._sendPhoneOtpUsecase, this._createPhoneAuthFromOtpUsecase)
      : super(AuthInitial()) {
    // Initialize authObj in the constructor body
    //it can be actual user data or dummy data if the user data is null
    _authObj = _localDataSource.fetchUserData();
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    /*
      note that PhoneOTPRequested & PhoneVerifyOTPRequested events required billing setup
      on google cloud console with card contains at least $300 dollars.
      i found out that after i wrote the code ...
    */
    on<PhoneOTPRequested>(_onPhoneOTPRequested);
    on<PhoneVerifyOTPRequested>(_onPhoneVerifyOTPRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    var result = await _loginUseCase.execute(LoginUseCaseInput(
      event.email,
      event.password,
    ));
    result.fold((failure) {
      _errMessage = '${failure.message.toString()} ${failure.code.toString()}';
      emit(LoginFailure(_errMessage!));
    }, (authenticationEntity) {
      _authObj = authenticationEntity;
      emit(LoginSuccess());
    });
  }

  void _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    var result = await _registerUseCase.execute(RegisterUseCaseInput(
      event.fullName,
      event.email,
      event.password,
      phoneAuthCredential: event.phoneAuthCredential,
      phone: event.phone,
      photo: event.photo,
    ));
    result.fold((failure) {
      _errMessage = '${failure.message.toString()} ${failure.code.toString()}';
      emit(RegisterFailure(_errMessage!));
    }, (authenticationEntity) {
      _authObj = authenticationEntity;
      emit(RegisterSuccess());
    });
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(LogoutLoading());
    var result = await _logoutUseCase.execute();
    result.fold((failure) {
      _errMessage = '${failure.message.toString()} ${failure.code.toString()}';
      emit(LogoutFailure(_errMessage!));
    }, (boolSuccess) {
      _authObj = null;
      emit(LogoutSuccess());
    });
  }

  void _onPhoneOTPRequested(
      PhoneOTPRequested event, Emitter<AuthState> emit) async {
    emit(PhoneOTPSendLoading());
    var result = await _sendPhoneOtpUsecase.execute(event.phone);
    result.fold((failure) {
      _errMessage = '${failure.message.toString()} ${failure.code.toString()}';
      emit(PhoneOTPSendFailure(_errMessage!));
    }, (otpEntity) {
      emit(PhoneOTPSendSuccess(otpEntity));
    });
  }

  void _onPhoneVerifyOTPRequested(
      PhoneVerifyOTPRequested event, Emitter<AuthState> emit) async {
    emit(PhoneOTPVerifyLoading());
    var result = await _createPhoneAuthFromOtpUsecase
        .execute(CreatePhoneAuthFromOtpInput(event.otp, event.sms));
    result.fold((failure) {
      _errMessage = '${failure.message.toString()} ${failure.code.toString()}';
      emit(PhoneOTPVerifyFailure(_errMessage!));
    }, (phoneAuthCredential) {
      emit(PhoneOTPVerifySuccess(phoneAuthCredential));
    });
  }
}
