import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class SettingsItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onPressed;
  final bool? needIconNext;
  final bool? needDivider;
  const SettingsItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.needIconNext,
    this.needDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: _button(context),
        ),
        needDivider == true
            ? const Divider(thickness: 2, indent: 50)
            : const SizedBox(height: 2),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kBasePadding, vertical: kPadding * 3),
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
    );
  }
}
