import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class RestorePasswordErrorContent extends StatelessWidget {
  const RestorePasswordErrorContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBottomSheetBottomPadding,
      ),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              'assets/icon/info-circle.svg',
              width: 36,
              height: 36,
              color: Colors.red,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              S.of(context).restore_password_error_title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
        const SizedBox(height: kBasePadding),
        Text(
          S.of(context).restore_password_error,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: S.of(context).ok,
        )
      ],
    );
  }
}
