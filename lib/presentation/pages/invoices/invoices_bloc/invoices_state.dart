// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoices_bloc.dart';

abstract class InvoicesState extends Equatable {
  const InvoicesState();

  @override
  List<Object?> get props => [];
}

class InvoicesInitialS extends InvoicesState {}

class InvoicesLoadingS extends InvoicesState {}

class InvoicesLoadedS extends InvoicesState {
  final InvoicesEntity data;
  final InvoicesSorting sortType;
  final int numberPages;
  final int currentPage;
  final InvoicesListParams params;

  const InvoicesLoadedS({
    required this.data,
    required this.numberPages,
    required this.currentPage,
    required this.params,
    this.sortType = InvoicesSorting.desk,
  });

  @override
  List<Object?> get props => [data, sortType];
}

class InvoicesEmptyS extends InvoicesState {
  final InvoicesEntity data;
  final InvoicesSortType sortType;
  const InvoicesEmptyS({
    required this.data,
    this.sortType = InvoicesSortType.firstNew,
  });

  @override
  List<Object?> get props => [data, sortType];
}

class InvoicesErrorS extends InvoicesState {
  final String message;

  const InvoicesErrorS({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
