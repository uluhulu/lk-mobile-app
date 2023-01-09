part of 'claim_drafts_list_bloc.dart';

abstract class ClaimDraftsListState extends Equatable {
  const ClaimDraftsListState();

  @override
  List<Object?> get props => [];
}

class ClaimDraftsListInitialS extends ClaimDraftsListState {}

class ClaimDraftsListLoadingS extends ClaimDraftsListState {}

class ClaimDraftsListLoadedS extends ClaimDraftsListState {
  final ClaimDraftsListEntity entity;
  final int numberPages;
  final int currentPage;
  final ClaimDraftsListParams params;
  final ClaimDraftsListSorting sorting;

  const ClaimDraftsListLoadedS({
    required this.entity,
    required this.numberPages,
    required this.currentPage,
    required this.params,
    required this.sorting,
  });

  @override
  List<Object?> get props => [entity, numberPages, currentPage, params];
}

class ClaimDraftsListEmptyS extends ClaimDraftsListState {
  final ClaimDraftsListEntity entity;

  const ClaimDraftsListEmptyS({
    required this.entity,
  });

  @override
  List<Object?> get props => [entity];
}

class ClaimDraftsListErrorS extends ClaimDraftsListState {
  final String message;

  const ClaimDraftsListErrorS({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
