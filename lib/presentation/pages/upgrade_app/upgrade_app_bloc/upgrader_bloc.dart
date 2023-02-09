import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../services/logger/logger_service.dart';
import '../../../../services/itunes/itunes_search_api.dart';
import '../../../../services/platform.dart';

part 'upgrader_event.dart';

part 'upgrader_state.dart';

class UpgraderBloc extends Bloc<UpgraderEvent, UpgraderState> {
  UpgraderBloc() : super(UpgraderOkS()) {
    on<UpgraderShouldUpdateE>(_shouldUpdate);
    on<UpgraderInitializeE>(_initialize);
    on<UpgraderOkE>(_ok);
    on<UpgraderLaunchUrlE>(_launchUrlString);
    add(const UpgraderInitializeE());
  }

  List<int> parseMainVersion(String version) {
    version = version.split('+').first;
    return version.split('.').map((e) => int.parse(e)).toList();
  }

  void _shouldUpdate(UpgraderShouldUpdateE event, Emitter<UpgraderState> emit) {
    try {
      final appStoreVersion = event.appStoreVersion;
      final installedVersion = event.installedVersion;
      List<int> appStoreVersions = parseMainVersion(appStoreVersion);
      List<int> installedVersions = parseMainVersion(installedVersion);

      int appStoreMajor = appStoreVersions[0];
      int installedMajor = installedVersions[0];
      int appStoreMinor = appStoreVersions[1];
      int installedMinor = installedVersions[1];
      int appStorePatch = appStoreVersions[2];
      int installedPatch = installedVersions[2];
      final isNeedUpdate =
          appStoreMajor > installedMajor || appStoreMinor > installedMinor;
      final hasUpdate = isNeedUpdate || appStorePatch > installedPatch;
      if (isNeedUpdate) {
        emit(UpgraderNeedUpdateS(
            minAppVersion: appStoreVersion, text: event.releaseNotes));
        return;
      }
      if (hasUpdate) {
        emit(UpgraderHasUpdateS(
            minAppVersion: appStoreVersion, text: event.releaseNotes));
        return;
      }
      L.i('willDisplayUpgrade: appStoreVersion=$appStoreVersion,  installedVersion=$installedVersion');
    } catch (e, s) {
      // AnalyticsClient().recordError(e, s);
    }
  }

  FutureOr<void> _initialize(
      UpgraderInitializeE event, Emitter<UpgraderState> emit) async {
    if (!isMobile()) return;
    final iTunes = ITunesSearchAPI();
    final itunesResponse = await ITunesSearchAPI()
        .lookupByBundleId('com.mkk.release', country: 'RU');
    final appStoreInfo = ((itunesResponse?['results'] as List<dynamic>).first
        as Map<String, dynamic>);
    final appStoreVersion = appStoreInfo['version'] as String? ?? '2.2.33';
    final releaseNotes =
        appStoreInfo['releaseNotes'] as String? ?? 'Текст обновления';
    final platform = await PackageInfo.fromPlatform();
    final version = platform.version;
    add(UpgraderShouldUpdateE(
        appStoreVersion: appStoreVersion,
        installedVersion: version,
        // installedVersion: "1.3.14+7",
        releaseNotes: releaseNotes));
  }

  FutureOr<void> _launchUrlString(
      UpgraderLaunchUrlE event, Emitter<UpgraderState> emit) async {
    try {
      if (isIOS()) {
        launchUrlString(
          'https://apps.apple.com/ru/app/%D1%84%D0%BA-%D0%BF%D1%83%D0%BB%D1%8C%D1%81-%D0%BB%D0%B8%D1%87%D0%BD%D1%8B%D0%B9-%D0%BA%D0%B0%D0%B1%D0%B8%D0%BD%D0%B5%D1%82/id1667593642',
          mode: LaunchMode.externalApplication,
        );
      } else if (isAndroid()) {
        launchUrlString(
          'https://play.google.com/store/apps/details?id=com.mkk.release',
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // AnalyticsClient().recordError(e, s);
    }
  }

  FutureOr<void> _ok(UpgraderOkE event, Emitter<UpgraderState> emit) {
    emit(UpgraderOkS());
  }
}
