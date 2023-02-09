part of 'network_logger_bloc.dart';

abstract class NetworkLoggerEvent extends Equatable {
  const NetworkLoggerEvent();

  @override
  List<Object> get props => [];
}

class NetworkLoggerShowE extends NetworkLoggerEvent {}
