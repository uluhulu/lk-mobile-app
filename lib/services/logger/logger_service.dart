import 'dart:convert';
import 'dart:developer';

import '../platform.dart';

class L {
  static void i(Object? msg, {String? tag}) {
    formatMsg(msg);
    if (isWeb()) {
      if (tag != null) {
        print('$tag: $msg');
      } else {
        print(msg);
      }
    } else {
      if (tag != null) {
        log('$tag: $msg', name: tag, level: 1);
      } else {

        log('$msg', name: 'I', level: 1);
      }
    }
  }
  static Object? formatMsg(Object? msg){
    if(msg is Map){
      return JsonEncoder.withIndent('  ').convert(msg);
    }
    return msg;
  }
  static void d(Object? msg, {String? tag}) {
    formatMsg(msg);
    if (isWeb()) {
      if (tag != null) {
        print('$tag: $msg');
      } else {
        print(msg);
      }
    } else {
      if (tag != null) {
        log('$tag: $msg', name: tag, level: 1);
      } else {
        log('$msg', name: 'I', level: 1);
      }
    }
  }

  static void e(Object? msg, {String? tag, StackTrace? stackTrace}) {
    formatMsg(msg);
    if (stackTrace != null) {
      msg = '$msg\n${stackTrace.toString()}\n';
    }
    if (isWeb()) {
      if (tag != null) {
        print('$tag: $msg');
      } else {
        print(msg);
      }
    } else {
      if (tag != null) {
        log('$tag: $msg', name: tag, level: 2);
      } else {
        log('$msg', name: 'E', level: 2);
      }
    }
  }

  static void j(Object? obj, {String? message, String? tag, StackTrace? stackTrace}) {
    var encoder = JsonEncoder.withIndent('\t');
    var json = encoder.convert(obj);
    var msg = message == null? json : '$message\n$json';
   if (stackTrace != null) {
      msg = '$msg\n${stackTrace.toString()}\n';
    }
    if (isWeb()) {
      if (tag != null) {
        print('$tag: $msg');
      } else {
        print(msg);
      }
    } else {
      if (tag != null) {
        log('$tag: $msg', name: tag, level: 2);
      } else {
        log('$msg', name: 'E', level: 2);
      }
    }
  }
}
