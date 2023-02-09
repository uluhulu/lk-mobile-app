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
  final int numberPages;
  final int currentPage;
  final InvoicesDetailProductsParams params;

  const InvoicesProductsLoadedS({
    required this.products,
    required this.numberPages,
    required this.currentPage,
    required this.params,
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
