// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import '../../../../../domain/repositories/repository.dart';
import '../../../../../services/error/bloc/error_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final ErrorBloc errorBloc;
  LoginBloc({
    required this.repository,
    required this.errorBloc,
  }) : super(LoginInitialS()) {
    on<LoginEventFetchFilialE>(_fetchFilial);
    on<LoginEventToggleCompanyE>(_toggleCompany);
    add(LoginEventFetchFilialE());
  }

  late DictionaryFilialEntity copyData;
  DictionaryData copyCompany = DictionaryData(id: 0, name: 'Не выбрано');

  FutureOr<void> _fetchFilial(
      LoginEventFetchFilialE event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingS());
      final result = await repository.dictionaryFilialList();
      copyData = result;
      emit(LoginLoadedS(data: result, company: result.data.first));
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _toggleCompany(
      LoginEventToggleCompanyE event, Emitter<LoginState> emit) {
    copyCompany = event.company;
    emit(LoginLoadedS(data: copyData, company: event.company));
  }
}
