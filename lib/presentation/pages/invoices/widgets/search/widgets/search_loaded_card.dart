import 'package:flutter/material.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/presentation/pages/invoices/widgets/search/widgets/search_invoice_card_opened.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/ui/card/expanded_card_widget.dart';
import '../../../../invoices_detail/widgets/card/invoices_detail_card_date_sum.dart';
import '../../../../invoices_detail/widgets/card/invoices_detail_card_title.dart';

class InvoicesSearchLoadedCard extends StatefulWidget {
  final InvoicesData invoicesSearch;

  const InvoicesSearchLoadedCard({
    Key? key,
    required this.invoicesSearch,
  }) : super(key: key);

  @override
  State<InvoicesSearchLoadedCard> createState() =>
      _InvoicesSearchLoadedCardState();
}

class _InvoicesSearchLoadedCardState extends State<InvoicesSearchLoadedCard> {
  InvoicesData get item => widget.invoicesSearch;

  var initiallyExpanded = false;

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
            InvoicesDetailCardTitle(
              title: item.edo,
              subtitle: item.customerOrderNumber,
            ),
            const SizedBox(height: kBasePadding),
            InvoicesDetailCardDateSum(
              date: item.date ?? '',
              price: Formatter.asCurrencyNum(item.sum),
            ),
            const SizedBox(height: kBasePadding),
            ExpandedCardWidget(
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
                SearchInvoiceCardOpened(data: item),
              ],
            ),
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
