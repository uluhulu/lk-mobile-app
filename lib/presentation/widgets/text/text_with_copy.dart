import 'package:flutter/material.dart';
import 'package:mkk/presentation/widgets/text/copy_text_widget.dart';

class TextWithCopy extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;
  const TextWithCopy(
    this.text, {
    super.key,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CopyTextWidget(
      onTap: onTap,
      copyData: text,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
