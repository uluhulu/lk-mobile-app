part of 'claim_draft_add_product_bloc.dart';

abstract class ClaimDraftAddProductEvent extends Equatable {
  const ClaimDraftAddProductEvent();

  @override
  List<Object> get props => [];
}

class ClaimDraftAddProductStartE extends ClaimDraftAddProductEvent {}

class ClaimDraftAddProductPaginationE extends ClaimDraftAddProductEvent {}

class ClaimDraftAddProductE extends ClaimDraftAddProductEvent {}

class ClaimDraftAddProductDeleteE extends ClaimDraftAddProductEvent {
  final int id;

  const ClaimDraftAddProductDeleteE({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ClaimDraftAddProductSaveE extends ClaimDraftAddProductEvent {}

class ClaimDraftSearchE extends ClaimDraftAddProductEvent {}

class ClaimDraftInitializeE extends ClaimDraftAddProductEvent {}
