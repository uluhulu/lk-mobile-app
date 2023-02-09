import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../../../app_loader/app_loader_bloc/app_loader_bloc.dart';
import '../../../create_claim/widgets/create_claim_product_save_content.dart';
import '../invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import '../widgets/error_content/invoice_add_overage_error_content.dart';
import 'invoice_add_overage_content.dart';
import 'invoice_add_overage_series_page.dart';
import 'invoice_overage_product_info.dart';

class InvoiceAddOveragesProvider extends StatelessWidget {
  final String guid;

  const InvoiceAddOveragesProvider({
    super.key,
    required this.guid,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InvoiceAddOverageBloc>(
          create: _createBloc,
        ),
        BlocProvider<ClaimsFilesCubit>(
          create: (context) => ClaimsFilesCubit(
            repository: sl.get<Repository>(),
          ),
        ),
      ],
      child: const InvoiceAddOveragesPage(),
    );
  }

  InvoiceAddOverageBloc _createBloc(BuildContext context) {
    return InvoiceAddOverageBloc(
      repository: sl.get<Repository>(),
      appLoaderBloc: context.read<AppLoaderBloc>(),
      guid: guid,
    );
  }
}

class InvoiceAddOveragesPage extends StatefulWidget {
  const InvoiceAddOveragesPage({
    super.key,
  });

  @override
  State<InvoiceAddOveragesPage> createState() => _InvoiceAddOveragesPageState();
}

class _InvoiceAddOveragesPageState extends State<InvoiceAddOveragesPage> {
  @override
  void initState() {
    super.initState();
    context.read<InvoiceAddOverageBloc>().add(InvoiceAddOverageInitializeE());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceAddOverageBloc, InvoiceAddOverageState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, InvoiceAddOverageState state) {
    final bloc = context.read<InvoiceAddOverageBloc>();

    if (state is InvoiceAddOveragesSeriesS) {
      return InvoiceAddOverageSeriesPage(product: state.product);
    }
    if (state is InvoiceAddOverageEditProductS) {
      var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
      cubit.setInitialClaimsDraftsAttachments(state.attachments);
      return WillPopScope(
        onWillPop: _onWillPop,
        child: InvoiceOverageProductInfo(
          data: state.product,
          attachments: state.attachments,
          draftId: state.draftId,
        ),
      );
    }
    if (state is InvoiceAddOverageErrorS) {
      return AppErrorWidget(
        callback: () => bloc.add(InvoiceAddOverageInitializeE()),
      );
    }
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        floatingActionButton: _navBarButton(bloc),
        child: InvoiceAddOverageContent(
          bloc: bloc,
        ),
      ),
    );
  }

  void _listener(BuildContext context, InvoiceAddOverageState state) {
    if (state is InvoiceAddOverageSaveSuccesS) {
      Navigator.of(context).popAndPushNamed(
        AppRoutes.claimDraftsInfo,
        arguments: ClaimsDraftsListPageParams(id: state.id),
      );
    }
    if (state is InvoiceAddOverageSaveErrorS) {
      BaseBottomSheetWidget(
        context: context,
        child: InvoiceAddOverageErrorContent(
          message: state.message,
          title: state.title,
        ),
      ).show();
    }
  }

  Widget _navBarButton(InvoiceAddOverageBloc bloc) {
    return SuperValidationBuilder(
        superValidation: bloc.product,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: isValid,
            btnWidth: 150,
            onPressed: () {
              bloc.add(InvoiceAddOverageSeriesE());
            },
            text: S.of(context).next,
          );
        });
  }

  Future<bool> _onWillPop() async {
    var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
    var bloc = BlocProvider.of<InvoiceAddOverageBloc>(context);

    BaseBottomSheetWidget(
      context: context,
      child: CreateClaimProductSaveContent(
        validation: context.read<InvoiceAddOverageBloc>().searchSeries,
        onSaved: () async {
          await cubit.deleteImages(isSaved: true);
          bloc.add(InvoiceAddOverageSaveE());
        },
        onCanceled: () async {
          await cubit.deleteImages(isSaved: false);
        },
      ),
    ).show();
    return Future.value(false);
  }
}
