part of 'claims_search_bloc.dart';

abstract class ClaimsSearchEvent extends Equatable {
  const ClaimsSearchEvent();

  @override
  List<Object> get props => [];
}

class ClaimsSearchFetchE extends ClaimsSearchEvent {}
