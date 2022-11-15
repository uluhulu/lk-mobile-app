import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/help/launch_url_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';

class RestorePasswordInfo extends StatelessWidget {
  const RestorePasswordInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).restore_password_info,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: kPadding),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: S.of(context).restore_password_info_2,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              TextSpan(
                  text: S.of(context).puls_email,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.blue,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      LaunchUrlHelper.launchEmail(S.of(context).puls_email);
                    }),
            ],
          ),
        ),
      ],
    );
  }
}
