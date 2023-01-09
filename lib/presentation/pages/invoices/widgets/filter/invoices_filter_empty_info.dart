import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/help/launch_url_helper.dart';
import '../../../../../generated/l10n.dart';

class FilterEmptyInfo extends StatelessWidget {
  final String? message;
  const FilterEmptyInfo({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: message ?? S.of(context).no_invoices,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                  text: S.of(context).try_another_date,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                    text: S.of(context).puls_email,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.blue,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        LaunchUrlHelper.launchHelpEmail(
                            S.of(context).puls_email);
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
