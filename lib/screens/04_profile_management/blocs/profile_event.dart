part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}
class UpdateProfile extends ProfileEvent {
  final UserModel updatedEmployee;

  UpdateProfile(this.updatedEmployee);
}
class UpdateAvatar extends ProfileEvent {
  final String email;
  final XFile? updatedAvatar;

  UpdateAvatar(this.email, this.updatedAvatar);
}

