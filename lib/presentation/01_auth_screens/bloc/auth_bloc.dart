import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../app/app_prefs.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppPreferences appPreferences;

  AuthBloc(this.appPreferences) : super(AuthInitial(loading: false)) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(LoginLoading(loading: true));
  }

  void _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {}

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {}
}
