import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../core/utils/constants.dart';

class ErrorIconWidget extends StatelessWidget {
  const ErrorIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: kErrorPadding),
      child: SvgPicture.asset(
        'assets/icon/info-circle.svg',
        width: 15,
        height: 15,
        color: myColors.errorColor,
      ),
    );
  }
}
