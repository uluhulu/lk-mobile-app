import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';

class ModalSheetTitleWidget extends StatelessWidget {
  const ModalSheetTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: 0,
        child: Text(S.of(context).region_company,
            style: Theme.of(context).textTheme.headline2));
  }
}
