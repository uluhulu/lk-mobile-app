part of 'claim_draft_add_overage_bloc.dart';

abstract class ClaimDraftAddOverageEvent extends Equatable {
  const ClaimDraftAddOverageEvent();

  @override
  List<Object> get props => [];
}

class ClaimDraftAddOverageSearchE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageSeriesE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageSearchSeriesE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageFiltersE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageInitialE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageInitializeE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageSaveE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageClearSeriesE extends ClaimDraftAddOverageEvent {}

class ClaimDraftAddOverageBackE extends ClaimDraftAddOverageEvent {}
