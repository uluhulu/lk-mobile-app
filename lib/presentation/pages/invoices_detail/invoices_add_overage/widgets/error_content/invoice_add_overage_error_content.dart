import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/buttons/primary_elevated_button.dart';

class InvoiceAddOverageErrorContent extends StatelessWidget {
  final String message;
  final String title;
  const InvoiceAddOverageErrorContent({
    super.key,
    required this.message,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icon/danger.svg',
              height: 40,
              width: 40,
              color: MyTheme.of(context).yellowColor,
            ),
            const SizedBox(height: kPadding),
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: S.of(context).ok,
            ),
            const SizedBox(height: kPadding),
          ],
        ));
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}
