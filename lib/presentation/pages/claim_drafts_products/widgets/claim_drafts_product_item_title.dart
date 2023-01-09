import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/widgets/text/text_with_copy.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../generated/l10n.dart';

class ClaimDraftsProductsItemTitle extends StatelessWidget {
  const ClaimDraftsProductsItemTitle({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithCopy(title, style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: kPadding / 2),
              TextWithCopy('${S.of(context).series}: $status',
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
