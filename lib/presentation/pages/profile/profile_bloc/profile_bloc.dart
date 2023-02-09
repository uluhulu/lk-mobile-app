// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../services/error/bloc/error_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Repository repository;
  final UserRepository userRepository;
  final ErrorBloc errorBloc;

  ProfileBloc({
    required this.repository,
    required this.userRepository,
    required this.errorBloc,
  }) : super(ProfileInitialS()) {
    on<ProfileFetchE>(_fetchProfile);
    add(ProfileFetchE());
  }

  FutureOr<void> _fetchProfile(
      ProfileFetchE event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingS());
      final result = await repository.getProfile();
      //await userRepository.saveUserRole(result.data.userRole.toString());
      emit(ProfileLoadedS(data: result));
    } catch (e) {
      emit(ProfileErrorS(message: e.toString()));
    }
  }

  int getUserRole(String role) {
    var roleId = 0;
    switch (role) {
      case ('client'):
        roleId = 1;
        break;
      case ('supplier'):
        roleId = 2;
        break;
      case ('mobile'):
        roleId = 3;
        break;
    }
    return roleId;
  }
}
