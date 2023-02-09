import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/core/help/navigation_claims_filter_page_params.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../../../invoices_detail/invoices_add_overage/widgets/error_content/invoice_add_overage_error_content.dart';
import '../../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../../claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import 'claim_draft_add_overage_content.dart';
import 'claim_draft_add_overage_series_page.dart';

class ClaimDraftAddOveragesPage extends StatefulWidget {
  final int id;

  const ClaimDraftAddOveragesPage({
    super.key,
    required this.id,
  });

  @override
  State<ClaimDraftAddOveragesPage> createState() =>
      _ClaimDraftAddOveragesPageState();
}

class _ClaimDraftAddOveragesPageState extends State<ClaimDraftAddOveragesPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ClaimDraftAddOverageBloc>()
        .add(ClaimDraftAddOverageInitializeE());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    return BlocConsumer<ClaimDraftAddOverageBloc, ClaimDraftAddOverageState>(
      builder: (context, state) {
        if (state is ClaimDraftAddOveragesSeriesS) {
          return ClaimDraftAddOverageSeriesPage(product: state.product);
        }
        if (state is ClaimDraftAddOverageErrorS) {
          return AppErrorWidget(
            callback: () => bloc.add(ClaimDraftAddOverageInitializeE()),
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
            child: ClaimDraftAddOverageContent(bloc: bloc, id: widget.id),
          ),
        );
      },
      listener: _listener,
    );
  }

  Widget _navBarButton(ClaimDraftAddOverageBloc bloc) {
    return SuperValidationBuilder(
        superValidation: bloc.product,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: isValid,
            btnWidth: 150,
            onPressed: () {
              context
                  .read<ClaimDraftAddOverageBloc>()
                  .add(ClaimDraftAddOverageSeriesE());
            },
            text: S.of(context).next,
          );
        });
  }

  void _listener(BuildContext context, ClaimDraftAddOverageState state) {
    final bloc = context.read<ClaimDraftsProductsBloc>();
    final claimErrorCubit = context.read<ClaimDraftsErrorCubit>();
    if (state is ClaimDraftAddOverageEditProductS) {
      Navigator.of(context).popAndPushNamed(AppRoutes.claimDraftProductInfo,
          arguments: ClaimsDraftsProductInfoParams(
            bloc: bloc,
            data: state.product,
            errorCubit: claimErrorCubit,
            id: widget.id,
          ));
    }
    if (state is ClaimDraftAddOverageSaveErrorS) {
      BaseBottomSheetWidget(
        context: context,
        child: InvoiceAddOverageErrorContent(
          message: state.message,
          title: state.title,
        ),
      ).show();
    }
  }
}
