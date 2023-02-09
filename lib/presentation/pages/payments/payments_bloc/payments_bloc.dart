// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/repository.dart';

import '../../../../data/api/receivables/info/entity/receivables_info_entity.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final Repository repository;
  PaymentsBloc({
    required this.repository,
  }) : super(PaymentsInitialS()) {
    on<PaymentsFetchE>(_fetchPayments);
    add(PaymentsFetchE());
  }

  FutureOr<void> _fetchPayments(
      PaymentsFetchE event, Emitter<PaymentsState> emit) async {
    try {
      //int userRole = sl.get<UserRepository>().getUserRole() ?? 0;
      emit(PaymentsLoadingS());
      final result = await repository.receivablesInfo();
      emit(PaymentsLoadedS(data: result));
    } catch (e) {
      emit(PaymentsErrorS(e.toString()));
    }
  }
}
