import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/help/launch_url_helper.dart';
import '../../../../generated/l10n.dart';

class HelpDetailBottomText extends StatelessWidget {
  const HelpDetailBottomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: RichText(
        text: TextSpan(
          text: S.of(context).help_detail_bottom_info_1,
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            const TextSpan(
              text: " ",
            ),
            TextSpan(
                text: S.of(context).puls_email,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.blue,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    LaunchUrlHelper.launchHelpEmail(S.of(context).puls_email);
                  }),
            const TextSpan(
              text: "\n",
            ),
            TextSpan(
              text: "\n${S.of(context).help_detail_bottom_info_2}",
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ],
        ),
      ),
    );
  }
}
