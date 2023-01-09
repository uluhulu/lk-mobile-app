import 'package:flutter/material.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/ui/card/expanded_card_widget.dart';
import 'claim_drafts_item_card_opened.dart';
import 'claim_drafts_item_card_title.dart';

class ClaimDraftsItemCard extends StatefulWidget {
  final ClaimDraftsListData claim;
  final VoidCallback onPressed;

  const ClaimDraftsItemCard({
    Key? key,
    required this.claim,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ClaimDraftsItemCard> createState() => _ClaimDraftsItemCardState();
}

class _ClaimDraftsItemCardState extends State<ClaimDraftsItemCard> {
  ClaimDraftsListData get item => widget.claim;
  var initiallyExpanded = false;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: _decoration(),
        child: _content(myColors, context),
      ),
    );
  }

  Widget _content(MyThemeData myColors, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBasePadding,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaimDraftsItemCardTitle(
            title: item.id.toString(),
            invoiceNumber: item.invoice ?? '',
            date: item.claimDate,
          ),
          const SizedBox(height: kPadding),
          const Divider(),
          ExpandedCardWidget(
            expandedAlignment: Alignment.centerLeft,
            arrowIconColor: myColors.primaryButtonColor,
            initiallyExpanded: initiallyExpanded,
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            title: Text(S.of(context).details,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: myColors.primaryButtonColor,
                    )),
            children: [
              ClaimDraftsItemCardOpened(item: item),
            ],
          ),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
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
}
