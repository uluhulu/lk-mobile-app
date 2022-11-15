import 'dart:io';

import 'package:flutter/foundation.dart';

bool fbBool() {
  if (!kIsWeb) {
    if (Platform.isLinux || Platform.isWindows) {
      return false;
    }
  }
  return true;
}

bool localNotificationBool() {
  if (kIsWeb) {
    return false;
  } else {
    if (Platform.isLinux || Platform.isWindows) {
      return false;
    }
  }
  return true;
}

bool isPc() {
  if (kIsWeb) {
    return false;
  } else {
    if (Platform.isLinux || Platform.isWindows) {
      return true;
    }
  }
  return false;
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isAndroid || Platform.isIOS;
  }
}

bool isMacOS() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isMacOS;
  }
}

bool isLinux() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isLinux;
  }
}

bool isWindows() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isWindows;
  }
}

bool isAndroid() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isAndroid;
  }
}

bool isIOS() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isIOS;
  }
}

bool isWeb() {
  return kIsWeb;
}

bool isApple() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isIOS || Platform.isMacOS;
  }
}
