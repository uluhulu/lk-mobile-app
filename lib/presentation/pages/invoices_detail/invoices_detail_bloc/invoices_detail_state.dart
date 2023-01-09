part of 'invoices_detail_bloc.dart';

abstract class InvoicesDetailState extends Equatable {
  const InvoicesDetailState();

  @override
  List<Object> get props => [];
}

class InvoicesDetailInitialS extends InvoicesDetailState {}

class InvoicesDetailLoadingS extends InvoicesDetailState {}

class InvoicesDetailLoadedS extends InvoicesDetailState {
  final InvoicesDetailEntity detail;

  const InvoicesDetailLoadedS({
    required this.detail,
  });

  @override
  List<Object> get props => [detail];
}

class InvoicesDetailErrorS extends InvoicesDetailState {
  final String message;

  const InvoicesDetailErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
