import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';

class InvoicesCardRowTitle extends StatelessWidget {
  const InvoicesCardRowTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: kPadding / 2),
              Text('${S.of(context).buyer_order}: $subtitle',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 14)),
            ],
          ),
        ),
        Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: MyTheme.of(context).secondaryButtonColor,
              borderRadius: BorderRadius.circular(kBorderRadius)),
          child: SvgPicture.asset(
            'assets/icon/arrow-right.svg',
          ),
        ),
      ],
    );
  }
}
