// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'act_bloc.dart';

abstract class ActState extends Equatable {
  const ActState();

  @override
  List<Object> get props => [];
}

class ActInitialS extends ActState {}

class ActLoadingS extends ActState {}

class ActLoadedS extends ActState {}

class ActDateRangeS extends ActState {
  final String start;
  final String end;
  const ActDateRangeS({
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [start, end];
}

class ActErrorS extends ActState {
  final String message;
  const ActErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
