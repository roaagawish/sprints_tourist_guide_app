part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class LoginLoading extends AuthState {
  const LoginLoading();
}

final class LoginSuccess extends AuthState {
  const LoginSuccess();
}

final class LoginFailure extends AuthState {
  final String errMessage;

  const LoginFailure(
    this.errMessage,
  );
}

final class RegisterLoading extends AuthState {
  const RegisterLoading();
}

final class RegisterSuccess extends AuthState {
  const RegisterSuccess();
}

final class RegisterFailure extends AuthState {
  final String errMessage;
  const RegisterFailure(
    this.errMessage,
  );
}

final class LogoutLoading extends AuthState {
  const LogoutLoading();
}

final class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

final class LogoutFailure extends AuthState {
  final String errMessage;
  const LogoutFailure(
    this.errMessage,
  );
}
