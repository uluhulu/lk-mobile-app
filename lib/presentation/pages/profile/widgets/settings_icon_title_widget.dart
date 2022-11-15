import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class SettingsIconTitleWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onPressed;
  final bool? needIconNext;
  const SettingsIconTitleWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.needIconNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBasePadding),
      child: InkWell(
        onTap: () {
          onPressed?.call();
        },
        child: Row(
          children: [
            icon,
            const SizedBox(width: kPadding * 2),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            needIconNext == null
                ? SvgPicture.asset('assets/icon/arrow-right.svg')
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
