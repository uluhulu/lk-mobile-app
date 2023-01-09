import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'add_product_info_page.dart';
import 'add_product_start_page.dart';

class CreateClaimPage extends StatelessWidget {
  final int draftId;

  const CreateClaimPage({
    super.key,
    required this.draftId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimDraftAddProductBloc, ClaimDraftAddProductState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, ClaimDraftAddProductState state) {
    if (state is ClaimDraftAddProductLoadingS) {
      return ScreenView(
        context: context,
        title: S.of(context).claim_drafts,
        child: const LoadingWidget(),
      );
    }
    if (state is ClaimDraftAddProductStartS) {
      return AddProductStartPage(entity: state.data);
    }
    if (state is ClaimDraftAddProductS) {
      return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: AddProductInfoPage(
          data: state.product,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Future<bool> _onWillPop(context) async {
    return (await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        )) ??
        false;
  }

  void _listener(BuildContext context, ClaimDraftAddProductState state) {
    if (state is ClaimDraftAddProductSaveSuccesS) {
      Navigator.of(context).pop();
    }
  }
}
