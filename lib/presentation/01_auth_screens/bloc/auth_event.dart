part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String? phone;
  final File? photo;

  RegisterRequested(
      {required this.fullName,
      required this.email,
      required this.password,
      this.phone,
      this.photo});
}

class LogoutRequested extends AuthEvent {}
