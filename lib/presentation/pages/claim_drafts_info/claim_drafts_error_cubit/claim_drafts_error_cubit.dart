import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_validation/super_validation_enum.dart';

import '../../../../data/api/claim_drafts/send/entity/claim_drafts_send_error_entity.dart';

part 'claim_drafts_error_state.dart';

class ClaimDraftsErrorCubit extends Cubit<ClaimDraftsErrorState> {
  ClaimDraftsErrorCubit() : super(ClaimDraftsErrorInitialS()) {
    _claimDraftsErrorCubitSubscription =
        stream.distinct().listen(_claimDraftsInfoListener);
  }

  late StreamSubscription<ClaimDraftsErrorState>
      _claimDraftsErrorCubitSubscription;

  @override
  Future<void> close() {
    _claimDraftsErrorCubitSubscription.cancel();
    return super.close();
  }

  void claimDraftsSendError(final ClaimsDraftSendError data) {
    emit(ClaimDraftsErrorSendS(data: data));
  }

  void _claimDraftsInfoListener(ClaimDraftsErrorState errorState) {
    if (errorState is ClaimDraftsErrorSendS) {
      final value = errorState.data?.errors.keys
              .map((e) => int.tryParse(e) ?? 0)
              .toList() ??
          [];
      itemValidation.value = value;
    }
  }

  void deleteErrorProduct(final int id) {
    final currentState = state;
    if (currentState is ClaimDraftsErrorSendS) {
      final data = currentState.data;
      if (data != null) {
        final errors = {...data.errors};
        errors.remove(id.toString());
        final ClaimsDraftSendError newData = ClaimsDraftSendError(
          message: data.message,
          errors: errors,
        );
        emit(ClaimDraftsErrorSendS(data: newData));
      }
    }
  }

  SuperValidationEnum<List<int>> itemValidation = SuperValidationEnum();
}
