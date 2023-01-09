import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/error/app_error_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'claim_draft_info_loaded.dart';

class ClaimDraftsInfoProvider extends StatelessWidget {
  final int id;
  const ClaimDraftsInfoProvider({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClaimDraftsInfoBloc>(
          create: _createInfoBloc,
        ),
        BlocProvider<ClaimDraftAddProductBloc>(
          create: _createAddProductBloc,
        ),
      ],
      child: ScreenView(
        needPadding: false,
        context: context,
        title: 'Черновик претензии',
        child: ClaimDraftsInfoContent(id: id),
      ),
    );
  }

  ClaimDraftsInfoBloc _createInfoBloc(BuildContext context) {
    return ClaimDraftsInfoBloc(
      repository: sl.get<Repository>(),
      //listBloc: context.read<ClaimDraftsListBloc>(),
      id: id,
    );
  }

  ClaimDraftAddProductBloc _createAddProductBloc(BuildContext context) {
    return ClaimDraftAddProductBloc(
      repository: sl.get<Repository>(),
      draftId: id,
    );
  }
}

class ClaimDraftsInfoContent extends StatelessWidget {
  final int id;
  const ClaimDraftsInfoContent({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimDraftsInfoBloc, ClaimDraftsInfoState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, ClaimDraftsInfoState state) {
    if (state is ClaimDraftsInfoLoadingS) {
      return const LoadingWidget();
    }
    if (state is ClaimDraftsInfoLoadedS) {
      return ClaimDraftsInfoLoaded(
        draft: state.data,
        claimProducts: state.claimProducts,
        id: id,
      );
    }
    if (state is ClaimDraftsInfoErrorS) {
      return const AppErrorWidget();
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, ClaimDraftsInfoState state) {
    if (state is ClaimDraftsSendErrorS) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    }
    if (state is ClaimDraftsSaveErrorS) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    }
    if (state is ClaimDraftsSendSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Претензия отправлена'),
        ),
      );
    }
  }
}
