part of 'claim_drafts_info_bloc.dart';

abstract class ClaimDraftsInfoEvent extends Equatable {
  const ClaimDraftsInfoEvent();

  @override
  List<Object> get props => [];
}

class ClaimDraftsInfoFetchE extends ClaimDraftsInfoEvent {}

class ClaimDraftsInfoSendE extends ClaimDraftsInfoEvent {}

class ClaimDraftsInfoSaveE extends ClaimDraftsInfoEvent {}

class ClaimDraftsInfoDeleteE extends ClaimDraftsInfoEvent {}
