part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}
class UpdateProfile extends ProfileEvent {}
class UpdateAvatar extends ProfileEvent {}

