import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/loading_widget.dart';
import '../../claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../../claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../../claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import '../../claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import '../claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../widgets/claim_drafts_products_empty.dart';
import 'claim_drafts_products_loaded.dart';

class ClaimDraftsProductsProvider extends StatelessWidget {
  final int id;
  const ClaimDraftsProductsProvider({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimDraftsProductsBloc>(
      create: _createBloc,
      child: ClaimDraftsProductsList(id: id),
    );
  }

  ClaimDraftsProductsBloc _createBloc(BuildContext context) {
    return ClaimDraftsProductsBloc(
      repository: sl.get<Repository>(),
      addProductBloc: context.read<ClaimDraftAddProductBloc>(),
      claimDraftsErrorCubit: context.read<ClaimDraftsErrorCubit>(),
      claimDraftsInfoBloc: context.read<ClaimDraftsInfoBloc>(),
      addOverageBloc: context.read<ClaimDraftAddOverageBloc>(),
      id: id,
    );
  }
}

class ClaimDraftsProductsList extends StatelessWidget {
  final int id;
  const ClaimDraftsProductsList({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimDraftsProductsBloc, ClaimDraftsProductsState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, ClaimDraftsProductsState state) {
    if (state is ClaimDraftsProductsLoadingS) {
      return const LoadingWidget();
    }
    if (state is ClaimDraftsProductsLoadedS) {
      return ClaimDraftsProductsLoaded(
        products: state.products,
        draftId: id,
      );
    }
    if (state is ClaimDraftsProductsEmptyS) {
      return ClaimDraftsProductsEmpty(draftId: id);
    }
    if (state is ClaimDraftsProductsErrorS) {
      return AppBaseErrorWidget(
        callback: () {
          context.read<ClaimDraftsProductsBloc>().add(
                ClaimDraftsProductsReloadE(),
              );
        },
      );
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, ClaimDraftsProductsState state) {
    if (state is ClaimDraftsProductsDeletedS) {
      Navigator.pop(context);
    }
  }
}
