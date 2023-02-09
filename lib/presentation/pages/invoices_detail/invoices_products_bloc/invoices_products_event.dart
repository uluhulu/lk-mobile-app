part of 'invoices_products_bloc.dart';

abstract class InvoicesProductsEvent extends Equatable {
  const InvoicesProductsEvent();

  @override
  List<Object> get props => [];
}

class InvoicesProductsFetchE extends InvoicesProductsEvent {
  final String uuid;
  final InvoicesDetailProductsParams params;

  const InvoicesProductsFetchE({
    required this.uuid,
    required this.params,
  });

  @override
  List<Object> get props => [uuid, params];
}

class InvoicesProductsRefreshE extends InvoicesProductsEvent {}
