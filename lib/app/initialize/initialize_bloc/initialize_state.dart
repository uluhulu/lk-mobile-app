part of 'initialize_bloc.dart';

@immutable
abstract class InitializeState {}

class InitializeAppSplashS extends InitializeState {}

class InitializeDoneS extends InitializeState {}

class InitializeErrorS extends InitializeState {
  final String error;
  InitializeErrorS(this.error);
}
