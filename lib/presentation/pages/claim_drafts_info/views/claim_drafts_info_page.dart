import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/app_loader/app_loader_bloc/app_loader_bloc.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/error/app_error_widget.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';
import '../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../claim_drafts_bloc/claim_drafts_info_bloc.dart';
import '../claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import '../widgets/bottom_sheet/claim_draft_send_error_content.dart';
import '../widgets/bottom_sheet/claim_draft_send_success_content.dart';
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
        BlocProvider<ClaimDraftsErrorCubit>(
          create: (context) => ClaimDraftsErrorCubit(),
          lazy: false,
        ),
        BlocProvider<ClaimDraftsInfoBloc>(
          create: _createInfoBloc,
        ),
        BlocProvider<ClaimDraftAddProductBloc>(
          create: _createAddProductBloc,
        ),
        BlocProvider<ClaimDraftAddOverageBloc>(
          create: _createAddOverageBloc,
        ),
        BlocProvider<ClaimsFilesCubit>(
          create: _createClaimsFilesCubit,
        ),
      ],
      child: ScreenView(
        needPadding: false,
        context: context,
        title: S.of(context).claim_draft,
        child: ClaimDraftsInfoContent(id: id),
      ),
    );
  }

  ClaimDraftsInfoBloc _createInfoBloc(BuildContext context) {
    return ClaimDraftsInfoBloc(
      repository: sl.get<Repository>(),
      appObserverBloc: context.read<ClaimDraftsObserverBloc>(),
      claimDraftsErrorCubit: context.read<ClaimDraftsErrorCubit>(),
      id: id,
    );
  }

  ClaimDraftAddProductBloc _createAddProductBloc(BuildContext context) {
    return ClaimDraftAddProductBloc(
      repository: sl.get<Repository>(),
      claimDraftsInfoBloc: context.read<ClaimDraftsInfoBloc>(),
      appLoader: context.read<AppLoaderBloc>(),
      draftId: id,
    );
  }

  ClaimDraftAddOverageBloc _createAddOverageBloc(BuildContext context) {
    return ClaimDraftAddOverageBloc(
      repository: sl.get<Repository>(),
      appLoaderBloc: context.read<AppLoaderBloc>(),
      draftId: id,
    );
  }

  ClaimsFilesCubit _createClaimsFilesCubit(BuildContext context) {
    return ClaimsFilesCubit(
      repository: sl.get<Repository>(),
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
      return AppErrorWidget(
        callback: () {
          context.read<ClaimDraftsInfoBloc>().add(ClaimDraftsInfoFetchE());
        },
      );
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, ClaimDraftsInfoState state) {
    if (state is ClaimDraftsSendErrorS) {
      BaseBottomSheetWidget(
        context: context,
        child: ClaimDraftSendErrorContent(
          message: state.message,
          data: state.data,
        ),
      ).show();
    }
    // if (state is ClaimDraftsSaveErrorS) {
    //   //TODO: написать ui для ошибки
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(state.message),
    //     ),
    //   );
    // }
    if (state is ClaimDraftsSendSuccess) {
      Navigator.of(context).pop();
      BaseBottomSheetWidget(
        context: context,
        child: ClaimDraftSendSuccessContent(
          data: state.data,
        ),
      ).show();
    }
  }
}
