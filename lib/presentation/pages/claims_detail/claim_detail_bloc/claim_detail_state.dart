part of 'claim_detail_bloc.dart';

abstract class ClaimDetailState extends Equatable {
  const ClaimDetailState();

  @override
  List<Object> get props => [];
}

class ClaimDetailInitialS extends ClaimDetailState {}

class ClaimDetailLoadingS extends ClaimDetailState {}

class ClaimDetailLoadedS extends ClaimDetailState {
  final ClaimDetailEntity claimDetail;

  const ClaimDetailLoadedS({
    required this.claimDetail,
  });

  @override
  List<Object> get props => [claimDetail];
}

class ClaimDetailErrorS extends ClaimDetailState {
  final String message;

  const ClaimDetailErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
