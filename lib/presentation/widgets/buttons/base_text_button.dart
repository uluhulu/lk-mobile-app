import 'package:flutter/material.dart';

import '../../../config/theme/elements/theme_data.dart';

class BaseTextButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onPressed;
  final bool canPress;
  final bool isLoading;
  const BaseTextButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.canPress = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(2)),
      child: TextButton.icon(
        onPressed: _enabled == true ? onPressed : null,
        icon: icon,
        label: Text(title, style: TextStyle(
          color: MyTheme.of(context).primaryButtonColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        )),
      ),
    );
  }

  bool get _enabled => canPress == true && isLoading == false;
}
