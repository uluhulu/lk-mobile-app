part of 'claim_drafts_counter_bloc.dart';

abstract class ClaimDraftsCounterEvent extends Equatable {
  const ClaimDraftsCounterEvent();

  @override
  List<Object> get props => [];
}

class ClaimDraftsCounterFetchE extends ClaimDraftsCounterEvent {}
