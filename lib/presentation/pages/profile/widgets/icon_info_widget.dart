import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class IconInfoWidget extends StatelessWidget {
  final String content;
  final Widget asset;
  final String? subtitle;
  final VoidCallback? onPressed;
  const IconInfoWidget({
    Key? key,
    required this.content,
    required this.asset,
    this.subtitle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            asset,
            const SizedBox(width: kPadding),
            InkWell(
              onTap: () {
                onPressed?.call();
              },
              child: Text(
                content,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: kPadding),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        const SizedBox(height: kBasePadding),
      ],
    );
  }
}
