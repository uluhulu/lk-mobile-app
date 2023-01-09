import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/loading_widget.dart';
import '../../claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
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
      child: const ClaimDraftsProductsList(),
    );
  }

  ClaimDraftsProductsBloc _createBloc(BuildContext context) {
    return ClaimDraftsProductsBloc(
      repository: sl.get<Repository>(),
      addProductBloc: context.read<ClaimDraftAddProductBloc>(),
      id: id,
    );
  }
}

class ClaimDraftsProductsList extends StatelessWidget {
  const ClaimDraftsProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimDraftsProductsBloc, ClaimDraftsProductsState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, ClaimDraftsProductsState state) {
    if (state is ClaimDraftsProductsLoadingS) {
      return const SmallLoadingWidget();
    }
    if (state is ClaimDraftsProductsLoadedS) {
      return ClaimDraftsProductsLoaded(
        products: state.products,
      );
    }
    //TODO: доделать
    if (state is ClaimDraftsProductsErrorS) {
      return Text('error');
    }

    if (state is ClaimDraftsProductsEmptyS) {
      return const ClaimDraftsProductsEmpty();
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, ClaimDraftsProductsState state) {
    if (state is ClaimDraftsProductsDeletedS) {
      Navigator.pop(context);
    }
  }
}
