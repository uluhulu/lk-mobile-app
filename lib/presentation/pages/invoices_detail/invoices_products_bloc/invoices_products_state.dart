part of 'invoices_products_bloc.dart';

abstract class InvoicesProductsState extends Equatable {
  const InvoicesProductsState();

  @override
  List<Object> get props => [];
}

class InvoicesProductsInitialS extends InvoicesProductsState {}

class InvoicesProductsLoadingS extends InvoicesProductsState {}

class InvoicesProductsLoadedS extends InvoicesProductsState {
  final InvoicesDetailProductsEntity products;

  const InvoicesProductsLoadedS({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class InvoicesProductsErrorS extends InvoicesProductsState {
  final String message;

  const InvoicesProductsErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
