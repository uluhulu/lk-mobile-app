part of 'claim_drafts_counter_bloc.dart';

abstract class ClaimDraftsCounterState extends Equatable {
  const ClaimDraftsCounterState();

  @override
  List<Object> get props => [];
}

class ClaimDraftsCounterInitialS extends ClaimDraftsCounterState {}

class ClaimDraftsCounterLoadedS extends ClaimDraftsCounterState {
  final int count;
  const ClaimDraftsCounterLoadedS(this.count);

  @override
  List<Object> get props => [count];
}
