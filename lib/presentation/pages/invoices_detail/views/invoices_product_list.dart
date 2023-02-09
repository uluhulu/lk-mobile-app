import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import '../../../../data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../../../widgets/loading_widget.dart';
import '../invoices_products_bloc/invoices_products_bloc.dart';
import 'invoices_product_list_loaded.dart';

class InvoicesProductsList extends StatelessWidget {
  final String uuid;
  const InvoicesProductsList({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesProductsBloc>();
    return BlocBuilder<InvoicesProductsBloc, InvoicesProductsState>(
      builder: (context, state) {
        if (state is InvoicesProductsLoadingS) {
          return const LoadingWidget();
        }
        if (state is InvoicesProductsLoadedS) {
          return InvoicesProductListLoaded(
            productsData: state.products,
            numberPages: state.numberPages,
            uuid: uuid,
            onPageChange: (int index) => bloc.add(
              InvoicesProductsFetchE(
                uuid: uuid,
                params: InvoicesDetailProductsParams(uuid: uuid, page: index),
              ),
            ),
          );
        }
        if (state is InvoicesProductsErrorS) {
          return AppBaseErrorWidget(
              message: 'Не удалось загрузить товары',
              callback: () {
                context.read<InvoicesProductsBloc>().add(
                      InvoicesProductsRefreshE(),
                    );
              });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
