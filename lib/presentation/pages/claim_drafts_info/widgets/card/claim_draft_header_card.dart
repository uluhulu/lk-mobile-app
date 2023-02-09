import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/widgets/card/claim_draft_header_opened.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';
import '../../../../widgets/ui/card/expanded_card_widget.dart';
import '../../../../widgets/ui/helpers/widget_or_null_column_helper.dart';
import '../claim_draft_info_message_card.dart';

class ClaimDraftHeaderCard extends StatefulWidget {
  final ClaimDraftsInfoData item;
  const ClaimDraftHeaderCard({
    super.key,
    required this.item,
  });

  @override
  State<ClaimDraftHeaderCard> createState() => _ClaimDraftHeaderCardState();
}

class _ClaimDraftHeaderCardState extends State<ClaimDraftHeaderCard> {
  bool initiallyExpanded = false;

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
            TextWithCopy('${S.of(context).claim_draft} ${widget.item.id}',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: myColors.whiteColor,
                    )),
            const SizedBox(height: kBasePadding),
            WidgetOrNullColumnHelper(
              isDetail: true,
              needPadding: false,
              title: S.of(context).invoice,
              value: widget.item.invoice,
            ),
            const SizedBox(height: kPadding),
            _details(myColors, context),
            const SizedBox(height: kBasePadding * 2),
            const ClaimDraftInfoMessageCard(),
            const SizedBox(height: kPadding),
          ],
        ),
      ),
    );
  }

  Widget _details(MyThemeData myColors, BuildContext context) {
    return ExpandedCardWidget(
      expandedAlignment: Alignment.centerLeft,
      arrowIconColor: myColors.whiteColor,
      initiallyExpanded: initiallyExpanded,
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      title: Text(S.of(context).details,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: myColors.whiteColor,
              )),
      expandedTitle: Text(S.of(context).hide,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: myColors.whiteColor,
              )),
      children: [
        ClaimDraftHeaderOpened(item: widget.item),
      ],
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
    return const EdgeInsets.only(
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBasePadding,
      top: kPadding * 3,
    );
  }
}
