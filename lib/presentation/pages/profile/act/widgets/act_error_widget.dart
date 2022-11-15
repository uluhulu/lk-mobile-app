import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/help/launch_url_helper.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/modal/modal_bottom_sheet_widget.dart';

class ActErrorWidget extends StatelessWidget {
  const ActErrorWidget({super.key});

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
              'assets/icon/info-circle.svg',
              height: 40,
              width: 40,
              color: MyTheme.of(context).errorColor,
            ),
            const SizedBox(height: kPadding),
            Text(
              'Ошибка!',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kBasePadding),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).act_error_info,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextSpan(
                      text: S.of(context).puls_email,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: MyTheme.of(context).primaryColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          LaunchUrlHelper().sendEmail(S.of(context).puls_email);
                        }),
                ],
              ),
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
