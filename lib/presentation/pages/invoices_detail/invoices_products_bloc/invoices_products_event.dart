part of 'invoices_products_bloc.dart';

abstract class InvoicesProductsEvent extends Equatable {
  const InvoicesProductsEvent();

  @override
  List<Object> get props => [];
}

class InvoicesProductsFetchE extends InvoicesProductsEvent {
  final String uuid;

  const InvoicesProductsFetchE({
    required this.uuid,
  });

  @override
  List<Object> get props => [uuid];
}

class InvoicesProductsRefreshE extends InvoicesProductsEvent {}
