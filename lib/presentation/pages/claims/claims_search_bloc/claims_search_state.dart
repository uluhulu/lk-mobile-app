part of 'claims_search_bloc.dart';

abstract class ClaimsSearchState extends Equatable {
  const ClaimsSearchState();

  @override
  List<Object> get props => [];
}

class ClaimsSearchInitialS extends ClaimsSearchState {}

class ClaimsSearchLoadingS extends ClaimsSearchState {}

class ClaimsSearchLoadedS extends ClaimsSearchState {
  final Data claimsData;

  const ClaimsSearchLoadedS({
    required this.claimsData,
  });

  @override
  List<Object> get props => [claimsData];
}

class ClaimsSearchErrorS extends ClaimsSearchState {
  final String message;

  const ClaimsSearchErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
