part of 'network_logger_bloc.dart';

abstract class NetworkLoggerState extends Equatable {
  const NetworkLoggerState();

  @override
  List<Object> get props => [];
}

class NetworkLoggerInitialS extends NetworkLoggerState {}

class NetworkLoggerShowS extends NetworkLoggerState {}
