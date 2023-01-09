import 'package:flutter/material.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitleWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle2),
        Text(subtitle, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
