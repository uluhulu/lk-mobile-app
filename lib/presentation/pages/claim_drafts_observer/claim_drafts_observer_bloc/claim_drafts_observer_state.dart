part of 'claim_drafts_observer.dart';

abstract class ClaimDraftsObserverState extends Equatable {
  const ClaimDraftsObserverState();

  @override
  List<Object> get props => [];
}

class ClaimDraftsObserverInitialS extends ClaimDraftsObserverState {}

class ClaimDraftsObserverNeedUpdateS extends ClaimDraftsObserverState {}
