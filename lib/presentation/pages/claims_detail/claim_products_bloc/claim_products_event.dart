part of 'claim_products_bloc.dart';

abstract class ClaimProductsEvent extends Equatable {
  const ClaimProductsEvent();

  @override
  List<Object> get props => [];
}

class ClaimProductsFetchE extends ClaimProductsEvent {}
