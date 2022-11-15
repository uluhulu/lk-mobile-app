// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mkk/domain/repositories/repository.dart';

import '../../../../../data/api/profile/act/params/profile_act_params.dart';

part 'act_event.dart';
part 'act_state.dart';

class ActBloc extends Bloc<ActEvent, ActState> {
  final Repository repository;
  ActBloc({
    required this.repository,
  }) : super(ActInitialS()) {
    on<ActRequestE>(_request);
  }

  FutureOr<void> _request(ActRequestE event, Emitter<ActState> emit) async {
    try {
      emit(ActLoadingS());
      await repository.getProfileAct(event.params);
      emit(ActLoadedS());
    } catch (e) {
      emit(ActErrorS(message: e.toString()));
    }
  }
}
