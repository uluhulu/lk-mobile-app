import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';

import '../../../../data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../services/error/bloc/error_bloc.dart';

part 'restore_password_event.dart';
part 'restore_password_state.dart';

class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  final Repository repository;
  final ErrorBloc errorBloc;
  RestorePasswordBloc({
    required this.repository,
    required this.errorBloc,
  }) : super(RestorePasswordInitialS()) {
    on<RestorePasswordFilialE>(_fetchFilial);
    on<RestorePasswordSendE>(_send);
    on<RestorePasswordToggleCompanyE>(_toggleCompany);
    add(RestorePasswordFilialE());
  }

  late DictionaryFilialEntity copyData;

  FutureOr<void> _fetchFilial(
      RestorePasswordFilialE event, Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      final result = await repository.dictionaryFilialList();
      copyData = result;
      emit(RestorePasswordLoadedS(data: result, company: result.data.first));
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _toggleCompany(
      RestorePasswordToggleCompanyE event, Emitter<RestorePasswordState> emit) {
    emit(RestorePasswordLoadedS(data: copyData, company: event.company));
  }

  FutureOr<void> _send(
      RestorePasswordSendE event, Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      final AuthForgotPasswordParams params = AuthForgotPasswordParams(
        username: event.login,
        filial: event.filial,
      );
      await repository.forgotPassword(params);
      emit(RestorePasswordEnterCodeS());
    } catch (e) {
      emit(RestorePasswordErrorS());
      add(RestorePasswordFilialE());
    }
  }
}
