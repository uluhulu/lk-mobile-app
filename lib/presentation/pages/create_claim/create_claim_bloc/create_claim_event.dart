part of 'create_claim_bloc.dart';

abstract class CreateClaimEvent extends Equatable {
  const CreateClaimEvent();

  @override
  List<Object> get props => [];
}

class CreateClaimStartE extends CreateClaimEvent {}

class CreateClaimProductE extends CreateClaimEvent {}

class CreateClaimDeleteProductE extends CreateClaimEvent {
  final int id;

  const CreateClaimDeleteProductE({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CreateClaimSaveE extends CreateClaimEvent {}
