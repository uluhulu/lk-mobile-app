import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../invoices_products_bloc/invoices_products_bloc.dart';
import 'invoices_product_list_loaded.dart';

class InvoicesProductsList extends StatelessWidget {
  const InvoicesProductsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicesProductsBloc, InvoicesProductsState>(
      builder: (context, state) {
        if (state is InvoicesProductsLoadingS) {
          return const LoadingWidget();
        }
        if (state is InvoicesProductsLoadedS) {
          return InvoicesProductListLoaded(
            productsData: state.products,
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
