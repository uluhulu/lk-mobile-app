part of 'claim_drafts_info_bloc.dart';

abstract class ClaimDraftsInfoState extends Equatable {
  const ClaimDraftsInfoState();

  @override
  List<Object> get props => [];
}

class ClaimDraftsInfoInitialS extends ClaimDraftsInfoState {}

class ClaimDraftsInfoLoadingS extends ClaimDraftsInfoState {}

class ClaimDraftsInfoLoadedS extends ClaimDraftsInfoState {
  final ClaimDraftsInfoEntity data;
  final ClaimDraftsProductsEntity claimProducts;

  const ClaimDraftsInfoLoadedS({
    required this.data,
    required this.claimProducts,
  });

  @override
  List<Object> get props => [data];
}

class ClaimDraftsInfoErrorS extends ClaimDraftsInfoState {
  final String message;

  const ClaimDraftsInfoErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ClaimDraftsSendSuccess extends ClaimDraftsInfoState {
  final ClaimDraftsSendEntity data;

  const ClaimDraftsSendSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class ClaimDraftsSendErrorS extends ClaimDraftsInfoState {
  final String message;

  const ClaimDraftsSendErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ClaimDraftsSaveSuccess extends ClaimDraftsInfoState {}

class ClaimDraftsSaveErrorS extends ClaimDraftsInfoState {
  final String message;

  const ClaimDraftsSaveErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
