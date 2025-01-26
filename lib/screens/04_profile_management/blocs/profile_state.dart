part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  UserModel get userData;
  MemoryImage? get avatar;
}

class ProfileInitial extends ProfileState {
  final UserModel userData;
  final MemoryImage? avatar;

  ProfileInitial({required this.userData, this.avatar});
}
class ProfileLoading extends ProfileState {
  final UserModel userData;
  final MemoryImage? avatar;

  ProfileLoading({required this.userData, this.avatar});
}
class ProfileLoaded extends ProfileState {
  final UserModel userData;
  final MemoryImage? avatar;

  ProfileLoaded({required this.userData, this.avatar});
}

class ProfileUpdated extends ProfileState {
  final UserModel userData;
  final MemoryImage? avatar;

  ProfileUpdated({required this.userData, this.avatar});
}

class ProfileError extends ProfileState {
  final UserModel userData;
  final MemoryImage? avatar;
  final String message;

  ProfileError({required this.userData, this.avatar, required this.message});
}
