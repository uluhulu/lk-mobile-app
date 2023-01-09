import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class NotificationContentWidget extends StatelessWidget {
  const NotificationContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return ListView(
      padding: const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBottomSheetBottomPadding,
      ),
      shrinkWrap: true,
      children: [
        Text(S.of(context).notifications,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: kBasePadding),
        Text(S.of(context).select_events,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: kPadding * 3),
        CheckboxListTile(
          value: true,
          side: BorderSide(width: 1, color: myColors.greyIconColor),
          activeColor: myColors.primaryButtonColor,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
          ),
          contentPadding: EdgeInsets.zero,
          onChanged: (value) {},
          title: Text(S.of(context).changed_status,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        const Divider(
          height: 40,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        CheckboxListTile(
          value: false,
          side: BorderSide(width: 1, color: myColors.greyIconColor),
          contentPadding: EdgeInsets.zero,
          onChanged: (value) {},
          title: Text(S.of(context).claim_messages,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(
          onPressed: () {},
          text: S.of(context).save,
        ),
        const SizedBox(height: kPadding * 3),
      ],
    );
  }
}
