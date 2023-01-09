import 'package:flutter/material.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';

class InvoicesDetailCardTitle extends StatelessWidget {
  const InvoicesDetailCardTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _invoicesText(context, myColors),
              const SizedBox(height: kPadding / 2),
              _orderText(context, myColors),
            ],
          ),
        ),
      ],
    );
  }

  Widget _invoicesText(BuildContext context, MyThemeData myColors) {
    final docNumber = title.split('_').first;
    return TextWithCopy('${S.of(context).invoice} $docNumber',
        style: Theme.of(context)
            .textTheme
            .headline2
            ?.copyWith(color: myColors.whiteColor));
  }

  Widget _orderText(BuildContext context, MyThemeData myColors) {
    return TextWithCopy('${S.of(context).buyer_order}: $subtitle',
        style: Theme.of(context)
            .textTheme
            .subtitle2
            ?.copyWith(fontSize: 14, color: myColors.whiteColor));
  }
}
