import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../invoices_detail/widgets/invoices_row_button.dart';
import '../widgets/search_invoice_products.dart';
import '../widgets/search_loaded_card.dart';

class InvoicesSearchLoaded extends StatelessWidget {
  final List<InvoicesData> invoicesSearch;
  const InvoicesSearchLoaded({
    Key? key,
    required this.invoicesSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: kBasePadding),
        InvoicesSearchLoadedCard(
          invoicesSearch: invoicesSearch.first,
        ),
        InvoicesRowButton(
          uuid: invoicesSearch.first.uuid,
        ),
        const SizedBox(height: kBasePadding),
        SearchInvoiceProductsProvider(
          uuid: invoicesSearch.first.uuid,
        ),
      ],
    );
  }
}
