part of 'claims_bloc.dart';

abstract class ClaimsEvent extends Equatable {
  const ClaimsEvent();

  @override
  List<Object> get props => [];
}

class ClaimsFetchE extends ClaimsEvent {
  final ClaimsParams params;
  const ClaimsFetchE({required this.params});

  @override
  List<Object> get props => [params];
}

class ClaimsSortListE extends ClaimsEvent {
  final ClaimsSorting type;

  const ClaimsSortListE({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class ClaimsResetFiltersE extends ClaimsEvent {}

class ClaimsApplyFiltersE extends ClaimsEvent {}

class ClaimsRefreshE extends ClaimsEvent {}
