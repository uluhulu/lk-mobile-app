import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';

class SettingsItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onPressed;
  final bool? needIconNext;
  final bool? needDivider;
  final Widget? widget;
  const SettingsItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.needIconNext,
    this.needDivider = true,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: _button(context),
        ),
        if (needDivider == true)
          Divider(
            thickness: 1,
            height: 0,
            indent: 56,
            color: MyTheme.of(context).mainDividerColor,
          )
        else
          const SizedBox(height: 2),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kBasePadding, vertical: 22),
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
          if (needIconNext == null)
            SvgPicture.asset('assets/icon/arrow-right.svg')
          else if (needIconNext == false)
            widget ?? const SizedBox.shrink()
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
