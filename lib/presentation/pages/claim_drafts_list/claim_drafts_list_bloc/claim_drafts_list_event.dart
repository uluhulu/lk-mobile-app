part of 'claim_drafts_list_bloc.dart';

abstract class ClaimDraftsListEvent extends Equatable {
  const ClaimDraftsListEvent();

  @override
  List<Object?> get props => [];
}

class ClaimDraftsListFetchE extends ClaimDraftsListEvent {
  final ClaimDraftsListParams params;
  const ClaimDraftsListFetchE({required this.params});

  @override
  List<Object?> get props => [params];
}

class ClaimDraftsDeleteE extends ClaimDraftsListEvent {
  final int id;
  const ClaimDraftsDeleteE({required this.id});

  @override
  List<Object?> get props => [id];
}
