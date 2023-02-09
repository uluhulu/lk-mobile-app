abstract class SettingsRepository {
  Future<void> setSavePhoto(bool value);

  bool getSavePhoto();
}
