import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mkk/data/api/claims/products/entity/claims_detail_products_entity.dart';
import 'package:mkk/presentation/widgets/ui/card/expanded_card_widget.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';
import 'claim_detail_item_card_opened.dart';

class ClaimDetailItemCard extends StatefulWidget {
  final ClaimsProductsData data;
  final String status;

  const ClaimDetailItemCard({
    Key? key,
    required this.data,
    required this.status,
  }) : super(key: key);

  @override
  State<ClaimDetailItemCard> createState() => _ClaimDetailItemCardState();
}

class _ClaimDetailItemCardState extends State<ClaimDetailItemCard> {
  var initiallyExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kBasePadding,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _content(context),
            const Divider(height: kPadding * 3),
            _detailContent(context),
            //const SizedBox(height: kPadding),
          ],
        ),
      ),
    );
  }

  Widget _detailContent(BuildContext context) {
    return ExpandedCardWidget(
      expandedAlignment: Alignment.centerLeft,
      initiallyExpanded: initiallyExpanded,
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      title: Text(S.of(context).details,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: MyTheme.of(context).primaryButtonColor,
              )),
      expandedTitle: Text(S.of(context).hide,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: MyTheme.of(context).primaryButtonColor,
              )),
      children: [
        ClaimDetailItemCardOpened(
          data: widget.data,
          status: widget.status,
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithCopy(widget.data.name,
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: kPadding / 2),
              TextWithCopy('${S.of(context).series} ${widget.data.seriesName}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16)),
              const SizedBox(height: kBasePadding),
              Text(S.of(context).decision,
                  style: Theme.of(context).textTheme.subtitle2),
              TextWithCopy(_getConclusion(),
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      ],
    );
  }

  String _getConclusion() {
    final conclusion = widget.data.conclusion;
    if (conclusion != null) {
      if (conclusion.isEmpty || conclusion == '') {
        return '—';
      } else {
        return conclusion;
      }
    }
    return '—';
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
