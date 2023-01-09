import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/text/text_with_copy.dart';

class ClaimStatusCardBuilder extends StatelessWidget {
  const ClaimStatusCardBuilder({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'Отклонена':
        return Row(
          children: [
            SvgPicture.asset(
              'assets/icon/close-circle.svg',
              width: 20,
              height: 20,
              color: MyTheme.of(context).whiteColor,
            ),
            const SizedBox(width: kPadding),
            TextWithCopy(
              status,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: MyTheme.of(context).whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        );

      case 'Удовлетворена':
        return Row(
          children: [
            SvgPicture.asset(
              'assets/icon/tick-circle.svg',
              width: 20,
              height: 20,
              color: MyTheme.of(context).whiteColor,
            ),
            const SizedBox(width: kPadding),
            TextWithCopy(
              status,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: MyTheme.of(context).whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        );

      default:
        return Row(
          children: [
            SvgPicture.asset(
              'assets/icon/timer.svg',
              width: 20,
              height: 20,
              color: MyTheme.of(context).whiteColor,
            ),
            const SizedBox(width: kPadding),
            TextWithCopy(
              status,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: MyTheme.of(context).whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        );
    }
  }
}
