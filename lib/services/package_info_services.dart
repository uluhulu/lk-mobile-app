import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  PackageInfoService._internal();

  static PackageInfoService? _instance;

  static PackageInfoService get instance =>
      _instance ??= PackageInfoService._internal();

  late PackageInfo packageInfo;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;
}
