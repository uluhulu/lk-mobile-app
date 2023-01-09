import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CopyTextHelper {
  static Future<void> copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text)).then(
      (_) {
        return Fluttertoast.showToast(
          msg: "Скопировано в буфер обмена",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      },
    );
  }
}
