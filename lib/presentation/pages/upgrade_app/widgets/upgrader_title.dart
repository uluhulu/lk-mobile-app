import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class UpgraderTitle extends StatelessWidget {
  final Color textColor;
  const UpgraderTitle({Key? key,required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).update_application,
      style: Theme.of(context).textTheme.headline2!.copyWith(
        color: textColor ,
      ),
    );
  }
}
