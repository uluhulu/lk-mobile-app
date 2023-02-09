part of 'upgrader_bloc.dart';


abstract class UpgraderEvent extends Equatable {
  const UpgraderEvent();

  @override
  List<Object> get props => [];
}

class UpgraderShouldUpdateE extends UpgraderEvent {
  final String appStoreVersion;
  final String installedVersion;
  final String releaseNotes;
  const UpgraderShouldUpdateE({
    required this.appStoreVersion,
    required this.installedVersion,
    required this.releaseNotes,
  });

  @override
  List<Object> get props => [appStoreVersion, installedVersion, releaseNotes];
}

class UpgraderInitializeE extends UpgraderEvent {
  const UpgraderInitializeE();
}

class UpgraderOkE extends UpgraderEvent {}
class UpgraderLaunchUrlE extends UpgraderEvent {}
