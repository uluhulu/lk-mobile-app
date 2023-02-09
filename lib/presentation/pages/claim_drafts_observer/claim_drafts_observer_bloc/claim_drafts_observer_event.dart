part of 'claim_drafts_observer.dart';

abstract class ClaimDraftsObserverEvent extends Equatable {
  const ClaimDraftsObserverEvent();

  @override
  List<Object> get props => [];
}

class AppObserverNeedUpdateE extends ClaimDraftsObserverEvent {}
