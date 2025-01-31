import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../data/data_source/local_data_source.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../../domain/usecase/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUsecase _registerUseCase;
  final LogoutUsecase _logoutUseCase;

  final LocalDataSource _localDataSource = instance();

  AuthenticationEntity? _authObj;
  String? _errMessage;

  AuthenticationEntity? get authObj => _authObj;

  AuthBloc(this._loginUseCase, this._registerUseCase, this._logoutUseCase)
      : super(AuthInitial()) {
    // Initialize authObj in the constructor body
    //it can be actual user data or dummy data if the user data is null
    _authObj = _localDataSource.fetchUserData();
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
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
}
