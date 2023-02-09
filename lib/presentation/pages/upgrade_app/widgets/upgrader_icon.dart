import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';

class UpgraderIcon extends StatelessWidget {
  const UpgraderIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return SvgPicture.asset(
      "assets/icon/danger.svg",
      width: 40,
      color: theme.yellowColor,
    );
  }
}
