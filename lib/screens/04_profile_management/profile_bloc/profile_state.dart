part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {}
class ProfileUpdated extends ProfileState {}
class ProfileError extends ProfileState {}
