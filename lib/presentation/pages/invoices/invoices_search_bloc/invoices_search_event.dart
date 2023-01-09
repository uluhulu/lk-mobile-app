part of 'invoices_search_bloc.dart';

abstract class InvoicesSearchEvent extends Equatable {
  const InvoicesSearchEvent();

  @override
  List<Object> get props => [];
}

class InvoicesSearchFetchE extends InvoicesSearchEvent {}
