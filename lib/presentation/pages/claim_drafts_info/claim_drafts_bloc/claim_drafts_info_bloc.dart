import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import 'package:mkk/data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:super_validation/super_validation_string.dart';

import '../../../../core/utils/resources/exception.dart';
import '../../../../data/api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import '../../../../domain/validators/claims/claim_draft_validation.dart';

part 'claim_drafts_info_event.dart';
part 'claim_drafts_info_state.dart';

class ClaimDraftsInfoBloc
    extends Bloc<ClaimDraftsInfoEvent, ClaimDraftsInfoState> {
  final Repository repository;
  //final ClaimDraftsListBloc listBloc;
  final int id;
  ClaimDraftsInfoBloc({
    required this.repository,
    //required this.listBloc,
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
        message.text = result.data.comment!;
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
      _initialize();
    } catch (e) {
      if (e is BadRequestHttpFailure) {
        if (e.data != null) {
          //final errors = ClaimDraftsSendErrorEntity.fromJson(e.data!);
          emit(ClaimDraftsSendErrorS(message: e.message));
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
      emit(ClaimDraftsInfoLoadingS());
      final params = ClaimDraftsSaveParams(comment: message.text, products: []);
      await repository.claimDraftsSave(id, params);
      _initialize();
      emit(ClaimDraftsSaveSuccess());
    } catch (e) {
      emit(ClaimDraftsSaveErrorS(message: e.toString()));
    } finally {
      _initialize();
    }
  }

  FutureOr<void> _deleteDrafts(
      ClaimDraftsInfoDeleteE event, Emitter<ClaimDraftsInfoState> emit) async {
    //listBloc.add(ClaimDraftsDeleteE(id: id));
  }
}
