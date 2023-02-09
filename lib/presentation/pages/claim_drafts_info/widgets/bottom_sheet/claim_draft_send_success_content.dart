import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../data/api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/text/text_with_copy.dart';

class ClaimDraftSendSuccessContent extends StatelessWidget {
  final ClaimDraftsSendEntity data;
  const ClaimDraftSendSuccessContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icon/tick-circle.svg',
              height: 40,
              width: 40,
              color: MyTheme.of(context).successColor,
            ),
            const SizedBox(height: kPadding),
            Text(
              S.of(context).claim_draft_sent,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kBasePadding),
            if (data.claims.length > 1)
              _claimDraftsCreated(context)
            else
              _claimDraftCreated(context),
            const SizedBox(height: kBasePadding),
            Text(S.of(context).claim_draft_created_info,
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: S.of(context).ok,
            ),
            const SizedBox(height: kPadding),
          ],
        ));
  }

  Widget _claimDraftsCreated(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).claim_drafts_created,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ListView.builder(
              itemCount: data.claims.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: kPadding),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TextWithCopy(
                  '• ${data.claims[index].number} от ${DateFormats.ddMMyyyyWithString(data.claims[index].date)}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                );
              }),
        ],
      ),
    );
  }

  Widget _claimDraftCreated(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: S.of(context).claim_draft_created,
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(
                text:
                    '${data.claims[0].number} от ${DateFormats.ddMMyyyyWithString(data.claims[0].date)}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kBasePadding),
        Text(
          S.of(context).claim_draft_created_info,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}
