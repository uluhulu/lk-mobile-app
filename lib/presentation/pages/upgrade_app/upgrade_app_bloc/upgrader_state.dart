part of 'upgrader_bloc.dart';

abstract class UpgraderState extends Equatable {
  const UpgraderState();

  @override
  List<Object> get props => [];
}

class UpgraderOkS extends UpgraderState {}

class UpgraderNeedUpdateS extends UpgraderState {
  final String minAppVersion;
  final String text;
  UpgraderNeedUpdateS({required this.minAppVersion, required this.text});

  @override
  List<Object> get props => [minAppVersion, text];
}

class UpgraderHasUpdateS extends UpgraderState {
  final String minAppVersion;
  final String text;
  UpgraderHasUpdateS({required this.minAppVersion, required this.text});

  @override
  List<Object> get props => [minAppVersion, text];
}
