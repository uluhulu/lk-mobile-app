import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/invoices/widgets/invoices_item_card_opened.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/ui/card/expanded_card_widget.dart';
import 'card/invoices_card_row_subtitle.dart';
import 'card/invoices_card_row_title.dart';

class InvoicesItemCard extends StatefulWidget {
  final InvoicesData data;
  final VoidCallback onPressed;

  const InvoicesItemCard({
    Key? key,
    required this.onPressed,
    required this.data,
  }) : super(key: key);

  @override
  State<InvoicesItemCard> createState() => _InvoicesItemCardState();
}

class _InvoicesItemCardState extends State<InvoicesItemCard> {
  InvoicesData get item => widget.data;

  var initiallyExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: _decoration(),
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: _contentPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InvoicesCardRowTitle(
            title: item.edo.split('_').first,
            subtitle: item.customerOrderNumber,
          ),
          const Divider(),
          const SizedBox(height: kPadding),
          InvoicesCardRowSubtitle(
            date: item.date ?? '',
            price: item.sum.toString(),
          ),
          const SizedBox(height: kBasePadding),
          ExpandedCardWidget(
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            initiallyExpanded: initiallyExpanded,
            title: Text(S.of(context).details,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: MyTheme.of(context).primaryButtonColor,
                    )),
            children: [
              InvoicesItemCardOpened(data: item),
            ],
          ),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }

  EdgeInsets _contentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: 12,
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
