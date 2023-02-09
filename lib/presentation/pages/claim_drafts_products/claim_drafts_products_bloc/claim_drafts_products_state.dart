part of 'claim_drafts_products_bloc.dart';

abstract class ClaimDraftsProductsState extends Equatable {
  const ClaimDraftsProductsState();

  @override
  List<Object> get props => [];
}

class ClaimDraftsProductsInitialS extends ClaimDraftsProductsState {}

class ClaimDraftsProductsLoadingS extends ClaimDraftsProductsState {}

class ClaimDraftsProductsLoadedS extends ClaimDraftsProductsState {
  final ClaimDraftsProductsEntity products;
  final ClaimDraftsProductsEntity limit;

  const ClaimDraftsProductsLoadedS({
    required this.products,
    required this.limit,
  });

  @override
  List<Object> get props => [products];
}

class ClaimDraftsProductsEmptyS extends ClaimDraftsProductsState {}

class ClaimDraftsProductsErrorS extends ClaimDraftsProductsState {}

class ClaimDraftsProductsDeletedS extends ClaimDraftsProductsState {}
