import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/invoices_detail/widgets/invoices_detail_item_opened_card.dart';
import 'package:mkk/presentation/widgets/ui/card/expanded_card_widget.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/text/text_with_copy.dart';

class InvoicesDetailItemCard extends StatefulWidget {
  final InvoicesDetailProductData data;

  const InvoicesDetailItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<InvoicesDetailItemCard> createState() => _InvoicesDetailItemCardState();
}

class _InvoicesDetailItemCardState extends State<InvoicesDetailItemCard> {
  var initiallyExpanded = false;

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
            ExpandedCardWidget(
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
                InvoicesDetailItemOpenedCard(data: widget.data),
              ],
            ),
            //const SizedBox(height: kPadding),
          ],
        ),
      ),
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
              TextWithCopy('${S.of(context).code} ${widget.data.code}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 14)),
            ],
          ),
        ),
      ],
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
