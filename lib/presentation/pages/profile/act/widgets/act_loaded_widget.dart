import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/modal/modal_bottom_sheet_widget.dart';

class ActLoadedWidget extends StatelessWidget {
  const ActLoadedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(
            top: kBasePadding * 2,
            left: kBasePadding,
            right: kBasePadding,
            bottom: kBottomSheetBottomPadding,
          ),
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/icon/tick-circle.svg',
              height: 40,
              width: 40,
              color: MyTheme.of(context).successColor,
            ),
            const SizedBox(height: kPadding),
            Text(
              S.of(context).act_request_success,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              S.of(context).manager_request_you,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: S.of(context).ok,
            ),
            const SizedBox(height: kPadding * 3),
          ],
        ),
        const DragHandleWidget(),
        const ModalBottomSheetIconBackWidget(),
      ],
    );
  }
}
