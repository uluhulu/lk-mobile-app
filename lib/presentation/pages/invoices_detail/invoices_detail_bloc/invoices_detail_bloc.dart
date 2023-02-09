import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/invoices/detail/entity/invoices_detail_entity.dart';
import 'package:mkk/data/api/invoices/detail/params/invoices_detail_params.dart';

import 'package:mkk/domain/repositories/repository.dart';

part 'invoices_detail_event.dart';
part 'invoices_detail_state.dart';

class InvoicesDetailBloc
    extends Bloc<InvoicesDetailEvent, InvoicesDetailState> {
  final Repository repository;
  final String uuid;

  InvoicesDetailBloc({
    required this.repository,
    required this.uuid,
  }) : super(InvoicesDetailInitialS()) {
    on<InvoicesDetailFetchE>(_fetchDetail);
    on<InvoicesDetailRefreshE>(_refreshDetail);
    //add(InvoicesDetailFetchE(uuid: uuid));
  }

  FutureOr<void> _fetchDetail(
      InvoicesDetailFetchE event, Emitter<InvoicesDetailState> emit) async {
    try {
      emit(InvoicesDetailLoadingS());
      final InvoicesDetailParams detailParams =
          InvoicesDetailParams(uuid: event.uuid);

      final InvoicesDetailEntity detailResult =
          await repository.invoicesDetail(detailParams);

      emit(InvoicesDetailLoadedS(
        detail: detailResult,
      ));
    } catch (e) {
      emit(InvoicesDetailErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _refreshDetail(
      InvoicesDetailRefreshE event, Emitter<InvoicesDetailState> emit) {
    final InvoicesDetailParams detailParams = InvoicesDetailParams(uuid: uuid);
    add(InvoicesDetailFetchE(uuid: uuid, params: detailParams));
  }
}
