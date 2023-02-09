part of 'claims_bloc.dart';

abstract class ClaimsState extends Equatable {
  const ClaimsState();

  @override
  List<Object> get props => [];
}

class ClaimsInitialS extends ClaimsState {}

class ClaimsLoadingS extends ClaimsState {}

class ClaimsLoadedS extends ClaimsState {
  final ClaimsEntity data;

  final ClaimsSorting sortType;
  final int numberPages;
  final int currentPage;
  final ClaimsParams params;

  const ClaimsLoadedS({
    required this.data,
    required this.numberPages,
    required this.currentPage,
    required this.params,
    this.sortType = ClaimsSorting.desk,
  });

  @override
  List<Object> get props => [data, sortType];
}

class ClaimsEmptyS extends ClaimsState {
  final ClaimsEntity data;

  final ClaimsSorting sortType;

  const ClaimsEmptyS({
    required this.data,
    this.sortType = ClaimsSorting.desk,
  });

  @override
  List<Object> get props => [data, sortType];
}

class ClaimsErrorS extends ClaimsState {
  final String message;
  const ClaimsErrorS({required this.message});
}
