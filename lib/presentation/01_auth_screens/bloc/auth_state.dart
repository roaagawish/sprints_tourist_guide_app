part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
    final bool loading ;
   const AuthState({required this.loading});
}

final class AuthInitial extends AuthState {
  const AuthInitial({required super.loading});
  
}

final class AuthAuthenticated extends  AuthState {
  final String email;
  const AuthAuthenticated({required this.email, required super.loading});
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({required super.loading});
} 

final class LoginLoading extends AuthState {
  const LoginLoading({required super.loading});
}

final class LoginSuccess extends AuthState {
  final String message;
  const LoginSuccess({ required super.loading, required this.message});
}

final class LoginFailure extends AuthState {
  final String errMessage;
  final bool isWrongPassword;
  final bool isAccountNotFound;
  
  const LoginFailure({ this.isWrongPassword =false , this.isAccountNotFound = false, required this.errMessage, required super.loading});
}

final class RegisterLoading extends AuthState {
  const RegisterLoading({required super.loading});
}

final class RegisterSuccess extends AuthState {
  final String message ;
  const RegisterSuccess( {required this.message , required super.loading});
}

final class RegisterFailure extends AuthState {
  final String errMessage;
  const RegisterFailure({required this.errMessage, required super.loading});
}

final class LogoutLoading extends AuthState {
  const LogoutLoading({required super.loading});
}

final class LogoutSuccess extends AuthState {
  final String message;
  const LogoutSuccess({ required this.message, required super.loading});
}

final class LogoutFailure extends AuthState {
  final String errMessage;
  const LogoutFailure({required this.errMessage, required super.loading});
}