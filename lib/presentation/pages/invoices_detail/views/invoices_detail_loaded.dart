import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/entity/invoices_detail_entity.dart';
import '../widgets/invoices_detail_card.dart';
import '../widgets/invoices_row_button.dart';
import 'invoices_product_list.dart';

class InvoicesDetailLoaded extends StatelessWidget {
  final InvoicesDetailEntity detailData;
  const InvoicesDetailLoaded({
    Key? key,
    required this.detailData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: kBasePadding),
        InvoicesDetailCard(
          data: detailData,
        ),
        InvoicesRowButton(
          uuid: detailData.data.invoice.uuid,
        ),
        const SizedBox(height: kBasePadding),
        const InvoicesProductsList(),
        const SizedBox(height: kBasePadding),
      ],
    );
  }
}
