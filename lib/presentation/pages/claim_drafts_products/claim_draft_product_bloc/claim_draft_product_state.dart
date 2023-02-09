part of 'claim_draft_product_cubit.dart';

abstract class ClaimDraftProductState extends Equatable {
  const ClaimDraftProductState();

  @override
  List<Object> get props => [];
}

class ClaimDraftProductInitialS extends ClaimDraftProductState {}

class ClaimDraftProductLoadedS extends ClaimDraftProductState {
  final List<ClaimDraftFile> attachments;
  final bool isAttachmentsLoading;

  const ClaimDraftProductLoadedS({
    required this.attachments,
    required this.isAttachmentsLoading,
  });

  @override
  List<Object> get props => [attachments];
}
