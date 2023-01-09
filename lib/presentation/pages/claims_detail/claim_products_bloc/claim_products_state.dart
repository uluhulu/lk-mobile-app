part of 'claim_products_bloc.dart';

abstract class ClaimProductsState extends Equatable {
  const ClaimProductsState();

  @override
  List<Object> get props => [];
}

class ClaimDetailProductsInitialS extends ClaimProductsState {}

class ClaimProductsLoadingS extends ClaimProductsState {}

class ClaimProductsLoadedS extends ClaimProductsState {
  final ClaimsDetailProductsEntity products;

  const ClaimProductsLoadedS({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ClaimProductsErrorS extends ClaimProductsState {
  final String message;

  const ClaimProductsErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
