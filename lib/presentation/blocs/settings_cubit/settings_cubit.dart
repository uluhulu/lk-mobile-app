import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/settings_repository.dart';

import '../../../locator/locator.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _initialize();
  }

  final SettingsRepository _settingsRepository = sl.get<SettingsRepository>();

  void getSavePhoto() {
    final bool savePhoto = _settingsRepository.getSavePhoto();
    emit(SettingsState(savePhoto: savePhoto));
  }

  Future<void> setSavePhoto(bool value) async {
    await _settingsRepository.setSavePhoto(value);
    emit(SettingsState(savePhoto: value));
  }

  void _initialize() {
    getSavePhoto();
  }
}
