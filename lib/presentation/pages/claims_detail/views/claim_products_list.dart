import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../claim_products_bloc/claim_products_bloc.dart';
import 'claim_products_list_loaded.dart';

class ClaimProductsList extends StatelessWidget {
  const ClaimProductsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimProductsBloc, ClaimProductsState>(
      builder: (context, state) {
        if (state is ClaimProductsLoadingS) {
          return const LoadingWidget();
        }
        if (state is ClaimProductsLoadedS) {
          return ClaimProductListLoaded(
            productsData: state.products,
          );
        }
        if (state is ClaimProductsErrorS) {
          return AppBaseErrorWidget(
              message: S.of(context).error_load_items,
              callback: () {
                context.read<ClaimProductsBloc>().add(
                      ClaimProductsFetchE(),
                    );
              });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
