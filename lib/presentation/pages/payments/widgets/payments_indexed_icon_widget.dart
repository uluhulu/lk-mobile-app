import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';

class IndexedIconWidget extends StatelessWidget {
  final int index;
  const IndexedIconWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPadding),
      child: indexedIcon(context, index),
    );
  }

  Widget indexedIcon(BuildContext context, int index) {
    final myColors = MyTheme.of(context);
    switch (index) {
      case 0:
        return SvgPicture.asset(
          'assets/icon/chart.svg',
          width: 24,
          height: 24,
          color: myColors.blueColor,
        );
      case 1:
        return SvgPicture.asset(
          'assets/icon/tick-circle.svg',
          width: 24,
          height: 24,
          color: myColors.successColor,
        );
      case 2:
        return SvgPicture.asset(
          'assets/icon/info-circle.svg',
          width: 24,
          height: 24,
          color: myColors.errorColor,
        );
      case 3:
        return SvgPicture.asset(
          'assets/icon/danger.svg',
          width: 24,
          height: 24,
          color: myColors.orangeColor,
        );
      default:
        return SvgPicture.asset(
          'assets/icon/danger.svg',
          width: 24,
          height: 24,
          color: myColors.orangeColor,
        );
    }
  }
}
