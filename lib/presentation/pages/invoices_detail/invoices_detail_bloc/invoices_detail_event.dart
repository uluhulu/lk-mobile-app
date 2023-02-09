part of 'invoices_detail_bloc.dart';

abstract class InvoicesDetailEvent extends Equatable {
  const InvoicesDetailEvent();

  @override
  List<Object> get props => [];
}

class InvoicesDetailFetchE extends InvoicesDetailEvent {
  final InvoicesDetailParams params;
  final String uuid;

  const InvoicesDetailFetchE({
    required this.params,
    required this.uuid,
  });

  @override
  List<Object> get props => [uuid, params];
}

class InvoicesDetailRefreshE extends InvoicesDetailEvent {}
