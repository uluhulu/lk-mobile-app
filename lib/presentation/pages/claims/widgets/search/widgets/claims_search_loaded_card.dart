import 'package:flutter/material.dart';
import 'package:mkk/core/utils/date_format.dart';
import 'package:mkk/data/api/claims/main/entity/claims_entity.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/text/text_with_copy.dart';
import '../../../../../widgets/ui/helpers/widget_or_null_column_helper.dart';
import '../../../../claims_detail/widgets/card/claim_message_card.dart';
import '../../../../claims_detail/widgets/card/claim_status_card.dart';

class ClaimsLoadedHeaderCard extends StatefulWidget {
  final Data claim;

  const ClaimsLoadedHeaderCard({
    Key? key,
    required this.claim,
  }) : super(key: key);

  @override
  State<ClaimsLoadedHeaderCard> createState() => _ClaimsLoadedHeaderCardState();
}

class _ClaimsLoadedHeaderCardState extends State<ClaimsLoadedHeaderCard> {
  Data get item => widget.claim;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      margin: _bodyPadding(),
      decoration: _decoration(myColors),
      child: Padding(
        padding: _contentPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWithCopy('${S.of(context).claim} ${item.number}',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: myColors.whiteColor,
                    )),
            const SizedBox(height: kBasePadding),
            ClaimStatusCard(status: item.status),
            const SizedBox(height: kPadding),
            WidgetOrNullColumnHelper(
              isDetail: true,
              title: S.of(context).date,
              value: DateFormats.isoDateFormatter(item.date),
            ),
            WidgetOrNullColumnHelper(
              isDetail: true,
              title: S.of(context).address,
              value: item.cargo.address,
            ),
            WidgetOrNullColumnHelper(
              isDetail: true,
              title: S.of(context).invoice,
              // widgetValue: SvgPicture.asset(
              //   'assets/icon/export1.svg',
              //   width: 20,
              //   height: 20,
              //   color: myColors.whiteColor,
              // ),
              value:
                  '${item.invoice.number} от ${DateFormats.isoDateFormatter(item.invoice.date)}',
            ),
            const SizedBox(height: kBasePadding * 2),
            ClaimMessageCard(claim: item),
            const SizedBox(height: kPadding),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration(MyThemeData myColors) {
    return BoxDecoration(
      color: myColors.blueDetailCardColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.30),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1.3),
        ),
      ],
    );
  }

  EdgeInsets _contentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: 12,
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.symmetric(
        horizontal: kBasePadding, vertical: kBasePadding);
  }
}
