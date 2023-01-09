import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/widgets/text/text_with_copy.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../generated/l10n.dart';

class ClaimDraftsItemCardTitle extends StatelessWidget {
  const ClaimDraftsItemCardTitle({
    Key? key,
    required this.title,
    required this.invoiceNumber,
    required this.date,
  }) : super(key: key);

  final String title;
  final String invoiceNumber;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithCopy('$title от ${DateFormats.isoDateFormatter(date)}',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: kPadding / 2),
              SizedBox(
                width: 250,
                child: TextWithCopy('${S.of(context).invoice}: $invoiceNumber',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontSize: 14)),
              ),
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
