import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:mkk/presentation/widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

import '../../../../../domain/repositories/repository.dart';
import '../../../../../locator/locator.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../create_claim/widgets/create_claim_product_save_content.dart';
import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'add_product_info_page.dart';
import 'add_product_start_page.dart';

class CreateClaimPage extends StatefulWidget {
  final int draftId;

  const CreateClaimPage({
    super.key,
    required this.draftId,
  });

  @override
  State<CreateClaimPage> createState() => _CreateClaimPageState();
}

class _CreateClaimPageState extends State<CreateClaimPage> {
  late ClaimDraftAddProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ClaimDraftAddProductBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimsFilesCubit>(
      create: (context) => ClaimsFilesCubit(repository: sl.get<Repository>())
        ..setInitialClaimsDraftsAttachments([]),
      child: BlocConsumer<ClaimDraftAddProductBloc, ClaimDraftAddProductState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, ClaimDraftAddProductState state) {
    if (state is ClaimDraftAddProductLoadingS) {
      return ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        child: const LoadingWidget(),
      );
    }
    if (state is ClaimDraftAddProductStartS) {
      return AddProductStartPage(entity: state.data);
    }
    if (state is ClaimDraftAddProductS) {
      var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
      cubit.setInitialClaimsDraftsAttachments(state.attachmentsList);
      return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: AddProductInfoPage(
          data: state.product,
        ),
      );
    }
    if (state is ClaimDraftAddProductErrorS) {
      return ScreenView(
          context: context,
          title: S.of(context).claim_drafts,
          child: AppErrorWidget(
              callback: () => bloc.add(
                    ClaimDraftAddProductStartE(),
                  )));
    }

    return const SizedBox.shrink();
  }

  Future<bool> _onWillPop(context) async {
    var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
    BaseBottomSheetWidget(
        context: context,
        child: CreateClaimProductSaveContent(
          validation: bloc.quantityClaim,
          onSaved: () async{
            Navigator.of(context).pop();
            await cubit.deleteImages(isSaved: true);
            bloc.add(ClaimDraftAddProductSaveE());
          },
          onCanceled: () async{
            await cubit.deleteImages(isSaved: false);
          },
        )).show();
    return Future.value(false);
  }

  void _listener(BuildContext context, ClaimDraftAddProductState state) {
    if (state is ClaimDraftAddProductSaveSuccesS) {
      Navigator.of(context).pop();
    }
  }
}
