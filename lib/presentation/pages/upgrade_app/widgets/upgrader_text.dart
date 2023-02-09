import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';

class UpgraderText extends StatelessWidget {
  final Color textColor;
  const UpgraderText({Key? key, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).update_application_text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        color:textColor,
        height: 1.4,
      ),
    );
  }
}
