import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/repositories/repository.dart';
import '../../../../../../locator/locator.dart';
import '../../../../invoices_detail/invoices_products_bloc/invoices_products_bloc.dart';
import '../../../../invoices_detail/views/invoices_product_list.dart';

class SearchInvoiceProductsProvider extends StatelessWidget {
  final String uuid;
  const SearchInvoiceProductsProvider({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoicesProductsBloc>(
      create: _createProductsBloc,
      child: InvoicesProductsList(uuid: uuid),
    );
  }

  InvoicesProductsBloc _createProductsBloc(BuildContext context) {
    return InvoicesProductsBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }
}
