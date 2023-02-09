part of 'appmetrica_bloc.dart';

@immutable
abstract class AppmetricaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppmetricaOnCrasheE extends AppmetricaEvent {
  final Object error;

  final StackTrace? stackTrace;

  AppmetricaOnCrasheE({
    required this.error,
    required this.stackTrace,
  });
  @override
  List<Object?> get props => [error, stackTrace];
}

class AppmetricaOnEventE extends AppmetricaEvent {
  final String eventName;


  AppmetricaOnEventE({
    required this.eventName,
  });
  @override
  List<Object?> get props => [eventName];
}
