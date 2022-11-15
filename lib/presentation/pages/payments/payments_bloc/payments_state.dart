// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

class PaymentsInitialS extends PaymentsState {}

class PaymentsLoadingS extends PaymentsState {}

class PaymentsLoadedS extends PaymentsState {
  final ReceivablesInfoEntity data;
  const PaymentsLoadedS({
    required this.data,
  });
}

class PaymentsErrorS extends PaymentsState {
  final String message;

  const PaymentsErrorS(this.message);

  @override
  List<Object> get props => [message];
}
