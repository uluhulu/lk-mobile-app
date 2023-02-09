part of 'claim_drafts_products_bloc.dart';

abstract class ClaimDraftsProductsEvent extends Equatable {
  const ClaimDraftsProductsEvent();

  @override
  List<Object> get props => [];
}

class ClaimDraftsProductsFetchE extends ClaimDraftsProductsEvent {
  final ClaimDraftsProductsParams params;

  const ClaimDraftsProductsFetchE({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

class ClaimDraftsProductsDeleteE extends ClaimDraftsProductsEvent {
  final int id;

  const ClaimDraftsProductsDeleteE({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ClaimDraftsProductsSaveE extends ClaimDraftsProductsEvent {
  // final int productId;
  final ClaimDraftsProductsModel model;

  const ClaimDraftsProductsSaveE({
    //required this.productId,
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class ClaimDraftsProductsReloadE extends ClaimDraftsProductsEvent {}
