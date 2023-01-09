import 'package:flutter/material.dart';

class NullCheckWidget extends StatelessWidget {
  final String? value;
  final Widget child;
  const NullCheckWidget({Key? key, this.value, required this.child, s})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == null || value == '' ? const SizedBox.shrink() : child;
  }
}
