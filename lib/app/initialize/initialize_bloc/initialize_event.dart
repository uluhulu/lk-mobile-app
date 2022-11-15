part of 'initialize_bloc.dart';

@immutable
abstract class InitializeEvent {}

class InitializeE extends InitializeEvent {}

class InitializeRevokeE extends InitializeEvent {}
