import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';

import '../platform.dart';

@lazySingleton
class VibrationService {
  Future<void> vibrate() async {
    if (!isMobile()) return;
    if (await Vibration.hasVibrator() ?? true) {
      return Vibration.vibrate(duration: 350);
    }
  }

  Future<void> buttonVibrate() async {
    if (!isMobile()) return;
    if (await Vibration.hasVibrator() ?? true) {
      return Vibration.vibrate(duration: 100);
    }
  }
}
