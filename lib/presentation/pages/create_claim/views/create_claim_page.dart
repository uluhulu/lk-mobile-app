import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/app_loader/app_loader_bloc/app_loader_bloc.dart';
import 'package:mkk/presentation/pages/create_claim/create_claim_bloc/create_claim_bloc.dart';
import 'package:mkk/presentation/pages/create_claim/views/create_claim_loaded.dart';
import 'package:mkk/presentation/pages/create_claim/widgets/create_claim_product_save_content.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import 'create_claim_product_info.dart';

class CreateClaimProvider extends StatelessWidget {
  final String uuid;

  const CreateClaimProvider({
    super.key,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateClaimBloc>(
          create: _createBloc,
        ),
        BlocProvider<ClaimsFilesCubit>(
          create: (context) =>
              ClaimsFilesCubit(repository: sl.get<Repository>())
                ..setInitialClaimsDraftsAttachments([]),
        )
      ],
      child: const CreateClaimContent(),
    );
  }

  CreateClaimBloc _createBloc(BuildContext context) {
    return CreateClaimBloc(
      repository: sl.get<Repository>(),
      appLoader: context.read<AppLoaderBloc>(),
      uuid: uuid,
    );
  }
}

class CreateClaimContent extends StatefulWidget {
  const CreateClaimContent({super.key});

  @override
  State<CreateClaimContent> createState() => _CreateClaimContentState();
}

class _CreateClaimContentState extends State<CreateClaimContent> {
  Future<bool> _onWillPop() async {
    var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
    var bloc = BlocProvider.of<CreateClaimBloc>(context);
    BaseBottomSheetWidget(
      context: context,
      child: CreateClaimProductSaveContent(
        validation: context.read<CreateClaimBloc>().quantityClaim,
        onSaved: () async {
          await cubit.deleteImages(isSaved: true);
          bloc.add(CreateClaimSaveE());
        },
        onCanceled: () async {
          await cubit.deleteImages(isSaved: false);
        },
      ),
    ).show();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateClaimBloc, CreateClaimState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, CreateClaimState state) {
    if (state is CreateClaimLoadingS) {
      return ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        child: const LoadingWidget(),
      );
    }
    if (state is CreateClaimStartS) {
      return CreateClaimLoaded(entity: state.data);
    }
    if (state is CreateClaimProductS) {
      var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
      cubit.setInitialClaimsDraftsAttachments(state.attachments);
      return WillPopScope(
        onWillPop: _onWillPop,
        child: CreateClaimProductInfo(
          data: state.product,
          claimdId: state.id,
        ),
      );
    }
    if (state is CreateClaimErrorS) {
      return ScreenView(
        context: context,
        title: S.of(context).claim_drafts,
        child: AppErrorWidget(callback: () {
          context.read<CreateClaimBloc>().add(CreateClaimStartE());
        }),
      );
    }

    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, CreateClaimState state) {
    if (state is CreateClaimSaveSuccesS) {
      Navigator.of(context).popAndPushNamed(
        AppRoutes.claimDraftsInfo,
        arguments: ClaimsDraftsListPageParams(id: state.id),
      );
    }
  }
}
