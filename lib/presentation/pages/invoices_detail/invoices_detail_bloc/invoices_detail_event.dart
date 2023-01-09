part of 'invoices_detail_bloc.dart';

abstract class InvoicesDetailEvent extends Equatable {
  const InvoicesDetailEvent();

  @override
  List<Object> get props => [];
}

class InvoicesDetailFetchE extends InvoicesDetailEvent {
  final String uuid;

  const InvoicesDetailFetchE({
    required this.uuid,
  });

  @override
  List<Object> get props => [uuid];
}

class InvoicesDetailRefreshE extends InvoicesDetailEvent {}
