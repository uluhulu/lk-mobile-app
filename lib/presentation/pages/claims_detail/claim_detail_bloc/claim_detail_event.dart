part of 'claim_detail_bloc.dart';

abstract class ClaimDetailEvent extends Equatable {
  const ClaimDetailEvent();

  @override
  List<Object> get props => [];
}

class ClaimDetailFetchE extends ClaimDetailEvent {}
