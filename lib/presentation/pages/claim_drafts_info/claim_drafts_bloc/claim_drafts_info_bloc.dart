import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import 'package:mkk/data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/services/logger/logger_service.dart';
import 'package:super_validation/super_validation_string.dart';

import '../../../../core/utils/resources/exception.dart';
import '../../../../data/api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import '../../../../data/api/claim_drafts/send/entity/claim_drafts_send_error_entity.dart';
import '../../../../domain/validators/claims/claim_draft_validation.dart';
import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';
import '../claim_drafts_error_cubit/claim_drafts_error_cubit.dart';

part 'claim_drafts_info_event.dart';
part 'claim_drafts_info_state.dart';

class ClaimDraftsInfoBloc
    extends Bloc<ClaimDraftsInfoEvent, ClaimDraftsInfoState> {
  final Repository repository;
  final ClaimDraftsObserverBloc appObserverBloc;
  final ClaimDraftsErrorCubit claimDraftsErrorCubit;
  final int id;
  ClaimDraftsInfoBloc({
    required this.repository,
    required this.appObserverBloc,
    required this.claimDraftsErrorCubit,
    required this.id,
  }) : super(ClaimDraftsInfoInitialS()) {
    on<ClaimDraftsInfoFetchE>(_fetchDetail);
    on<ClaimDraftsInfoSendE>(_sendClaim);
    on<ClaimDraftsInfoSaveE>(_saveClaim);
    on<ClaimDraftsInfoDeleteE>(_deleteDrafts);

    _initialize();
  }

  void _initialize() {
    add(ClaimDraftsInfoFetchE());
  }

  FutureOr<void> _fetchDetail(
      ClaimDraftsInfoFetchE event, Emitter<ClaimDraftsInfoState> emit) async {
    try {
      emit(ClaimDraftsInfoLoadingS());
      final result = await repository.claimDraftsInfo(id);
      final claimProducts = await repository.claimDraftProducts(
        id,
        ClaimDraftsProductsParams(id: id),
      );
      if (result.data.comment != null) {
        message.text = result.data.comment ?? '';
      }
      emit(ClaimDraftsInfoLoadedS(
        data: result,
        claimProducts: claimProducts,
      ));
    } catch (e) {
      emit(ClaimDraftsInfoErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _sendClaim(
      ClaimDraftsInfoSendE event, Emitter<ClaimDraftsInfoState> emit) async {
    try {
      emit(ClaimDraftsInfoLoadingS());
      final result = await repository.claimDraftSend(id);
      emit(ClaimDraftsSendSuccess(data: result));
      appObserverBloc.add(AppObserverNeedUpdateE());
    } catch (e) {
      if (e is BadRequestHttpFailure) {
        if (e.data != null) {
          final parseToString = const JsonEncoder().convert(e.data);
          if (parseToString.contains('Претензия должна содержать')) {
            emit(const ClaimDraftsSendErrorS(
                message: 'Претензия должна содержать хотя бы один товар'));
            return;
          }
          final data = ClaimsDraftSendError.fromJson(e.data ?? {});
          claimDraftsErrorCubit.claimDraftsSendError(data);
          emit(ClaimDraftsSendErrorS(data: data));
        }
      }
    } finally {
      _initialize();
    }
  }

  final SuperValidation message =
      SuperValidation(validationFunc: ClaimDraftValidator.messageValidator);

  FutureOr<void> _saveClaim(
      ClaimDraftsInfoSaveE event, Emitter<ClaimDraftsInfoState> emit) async {
    try {
      //emit(ClaimDraftsInfoLoadingS());
      final params = ClaimDraftsSaveParams(
          comment: Formatter.textFormatter(message.text), products: []);
      await repository.claimDraftsSave(id, params);
      emit(ClaimDraftsSaveSuccess());
    } catch (e) {
      emit(ClaimDraftsInfoErrorS(message: e.toString()));
      //emit(ClaimDraftsSaveErrorS(message: e.toString()));
    } finally {
      _initialize();
    }
  }

  FutureOr<void> _deleteDrafts(
      ClaimDraftsInfoDeleteE event, Emitter<ClaimDraftsInfoState> emit) async {
    try {
      await repository.claimDraftsDelete(id);
      appObserverBloc.add(AppObserverNeedUpdateE());
    } catch (e) {
      L.e('ClaimDraftsInfoBloc delete draft error $e');
    }
  }

  @override
  Future<void> close() {
    message.dispose();
    return super.close();
  }
}
