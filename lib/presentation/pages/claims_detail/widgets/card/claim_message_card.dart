import 'package:flutter/material.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../data/api/claims/main/entity/claims_entity.dart';

class ClaimMessageCard extends StatelessWidget {
  final Data claim;
  const ClaimMessageCard({
    super.key,
    required this.claim,
  });

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context, claim, myColors),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: kBasePadding, vertical: 14),
          decoration: BoxDecoration(
            color: myColors.deepBlueCardColor,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Text(
            _claimMessage(claim),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: myColors.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  String _claimMessage(Data claim) {
    if (claim.comment != null && claim.comment != '') {
      return claim.comment!;
    } else {
      return '—';
    }
  }

  Widget _header(BuildContext context, Data claim, MyThemeData myColors) {
    if (claim.comment != null && claim.comment != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).comment,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: myColors.deepBlueTextColor),
          ),
          claim.date != null || claim.date.isNotEmpty
              ? Text(
                  //TODO: Поменять дату сообщения после работки API
                  '${S.of(context).your_message_from} ${DateFormats.isoDateTimeFormatterWithUTC(claim.date)}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: myColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 12),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: kPadding),
        child: Text(
          S.of(context).comment,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.deepBlueTextColor),
        ),
      );
    }
  }
}
