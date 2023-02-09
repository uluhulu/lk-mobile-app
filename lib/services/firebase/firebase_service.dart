import 'dart:async';

import '../../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

import '../logger/logger_service.dart';
import '../platform.dart';

@lazySingleton
class FirebaseService {
  FirebaseApp? app;
  FutureOr<void> initialize() async {
    if (isPc()) {
      return;
    }
    try {
      app = Firebase.app();
      L.i('Current FirebaseApp: ${app?.options}');
    } catch (e) {
      FirebaseOptions? options = DefaultFirebaseOptions.currentPlatform;
      try {
        final apps = Firebase.apps;
        for (final app in apps) {
          if (app.name != 'DEFAULT') {
            await app.delete();
          }
        }
      } catch (e) {
        L.i('Error while get apps');
      }
      try {
        L.i('FirebaseOptions: $options');
        app = await Firebase.initializeApp(options: options);
      } catch (e) {
        L.i('Firebase Initialize Error: $e');
      }
    }
  }
}
