part of 'claim_drafts_error_cubit.dart';

abstract class ClaimDraftsErrorState extends Equatable {
  const ClaimDraftsErrorState();

  @override
  List<Object?> get props => [];
}

class ClaimDraftsErrorInitialS extends ClaimDraftsErrorState {}

class ClaimDraftsErrorSendS extends ClaimDraftsErrorState {
  final ClaimsDraftSendError? data;

  const ClaimDraftsErrorSendS({
    this.data,
  });

  @override
  List<Object?> get props => [data];
}
