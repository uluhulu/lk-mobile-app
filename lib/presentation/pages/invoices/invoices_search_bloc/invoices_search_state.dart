part of 'invoices_search_bloc.dart';

abstract class InvoicesSearchState extends Equatable {
  const InvoicesSearchState();

  @override
  List<Object> get props => [];
}

class InvoicesSearchInitialS extends InvoicesSearchState {}

class InvoicesSearchLoadingS extends InvoicesSearchState {}

class InvoicesSearchLoadedS extends InvoicesSearchState {
  final List<InvoicesData> invoicesSearch;

  const InvoicesSearchLoadedS({
    required this.invoicesSearch,
  });

  @override
  List<Object> get props => [invoicesSearch];
}

class InvoicesSearchErrorS extends InvoicesSearchState {
  final String message;

  const InvoicesSearchErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
