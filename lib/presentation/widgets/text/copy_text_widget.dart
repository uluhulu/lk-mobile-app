import 'package:flutter/material.dart';

import 'copy_text_helper.dart';

class CopyTextWidget extends StatelessWidget {
  final String? copyData;
  final Widget child;
  final VoidCallback? onTap;
  const CopyTextWidget({
    Key? key,
    this.copyData,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () async {
        await CopyTextHelper.copyText(copyData ?? '');
      },
      child: child,
    );
  }
}
