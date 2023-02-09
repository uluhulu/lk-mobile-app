part of 'claim_draft_add_overage_bloc.dart';

abstract class ClaimDraftAddOverageState extends Equatable {
  const ClaimDraftAddOverageState();

  @override
  List<Object> get props => [];
}

class ClaimDraftAddOverageInitialS extends ClaimDraftAddOverageState {}

class ClaimDraftAddOverageProductS extends ClaimDraftAddOverageState {
  final ClaimDraftsFindOveragesEntity entity;
  const ClaimDraftAddOverageProductS({
    required this.entity,
  });

  @override
  List<Object> get props => [entity];
}

class ClaimDraftAddOveragesSeriesS extends ClaimDraftAddOverageState {
  final ClaimDraftFindOverageData product;
  const ClaimDraftAddOveragesSeriesS({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ClaimDraftAddOverageEditProductS extends ClaimDraftAddOverageState {
  final ClaimDraftsProductsData product;
  const ClaimDraftAddOverageEditProductS({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ClaimDraftAddOverageSearchErrorS extends ClaimDraftAddOverageState {
  final String message;

  const ClaimDraftAddOverageSearchErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ClaimDraftAddOverageLoadingS extends ClaimDraftAddOverageState {}

class ClaimDraftAddOverageErrorS extends ClaimDraftAddOverageState {}

class ClaimDraftAddOverageSaveErrorS extends ClaimDraftAddOverageState {
  final String message;
  final String title;

  const ClaimDraftAddOverageSaveErrorS({
    required this.message,
    required this.title,
  });

  @override
  List<Object> get props => [message, title];
}
