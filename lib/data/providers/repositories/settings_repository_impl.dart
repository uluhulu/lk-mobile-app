import 'package:injectable/injectable.dart';
import 'package:mkk/domain/repositories/settings_repository.dart';

import '../../../locator/locator.dart';
import '../local_store_provider.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl();

  final LocalStoreProvider _localStoreProvider = sl.get<LocalStoreProvider>();

  @override
  bool getSavePhoto() => _localStoreProvider.getSavePhoto();

  @override
  Future<void> setSavePhoto(bool value) =>
      _localStoreProvider.setSavePhoto(value);
}
