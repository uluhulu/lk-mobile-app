part of 'invoices_bloc.dart';

abstract class InvoicesEvent extends Equatable {
  const InvoicesEvent();

  @override
  List<Object> get props => [];
}

class InvoicesFetchE extends InvoicesEvent {
  final InvoicesListParams params;

  const InvoicesFetchE({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

class InvoicesResetFiltersE extends InvoicesEvent {}

class InvoicesSortListE extends InvoicesEvent {
  final InvoicesSorting type;

  const InvoicesSortListE({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class InvoicesApplyFiltersE extends InvoicesEvent {}

class InvoicesRefreshE extends InvoicesEvent {}
