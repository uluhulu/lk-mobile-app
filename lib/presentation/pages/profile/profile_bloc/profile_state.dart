part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialS extends ProfileState {}

class ProfileLoadingS extends ProfileState {}

class ProfileLoadedS extends ProfileState {
  final ProfileInfoEntity data;

  const ProfileLoadedS({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}