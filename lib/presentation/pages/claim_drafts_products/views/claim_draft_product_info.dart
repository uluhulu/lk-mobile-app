import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_draft_product_bloc/claim_draft_product_cubit.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/widgets/claim_drafts_product_nav_bar.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_row_helper.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/image_picker/attachments_load_error.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../widgets/image_picker/custom_image_picker.dart';
import '../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../../claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import '../../create_claim/widgets/create_claim_product_save_content.dart';
import '../widgets/fields/claim_draft_product_coment_field.dart';
import '../widgets/fields/claim_draft_product_quantity_field.dart';
import '../widgets/fields/claim_draft_product_selector_field.dart';
import 'claim_draft_product_files.dart';

class ClaimDraftProductProvider extends StatelessWidget {
  final ClaimDraftsProductsData data;
  final int draftId;

  const ClaimDraftProductProvider({
    super.key,
    required this.data,
    required this.draftId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimDraftProductBloc>(
      create: _crateBloc,
      child: ClaimDraftProductInfo(
        data: data,
      ),
    );
  }

  ClaimDraftProductBloc _crateBloc(BuildContext context) {
    return ClaimDraftProductBloc(
      productsBloc: context.read<ClaimDraftsProductsBloc>(),
      errorCubit: context.read<ClaimDraftsErrorCubit>(),
      data: data,
      repository: sl.get<Repository>(),
      draftId: draftId,
      filesCubit: context.read<ClaimsFilesCubit>(),
    );
  }
}

class ClaimDraftProductInfo extends StatefulWidget {
  final ClaimDraftsProductsData data;

  const ClaimDraftProductInfo({
    super.key,
    required this.data,
  });

  @override
  State<ClaimDraftProductInfo> createState() => _ClaimDraftProductInfoState();
}

class _ClaimDraftProductInfoState extends State<ClaimDraftProductInfo> {
  late ClaimDraftProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ClaimDraftProductBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: ScreenView(
          context: context,
          needPadding: false,
          title: S.of(context).claim_draft,
          child: Column(
            children: [
              ClaimDraftProductInfoContent(
                bloc: bloc,
                data: widget.data,
              ),
              ClaimDraftProductNavBar(id: widget.data.id),
            ],
          )),
    );
  }

  Future<bool> _onWillPop(
    context,
  ) async {
    bloc.isEditable
        ? BaseBottomSheetWidget(
            context: context,
            child: CreateClaimProductSaveContent(
              validation: bloc.quantityClaim,
              onSaved: () {
                bloc.save();
                Navigator.of(context).pop();
              },
              onCanceled: () {
                bloc.deleteNewImage();
              },
            )).show()
        : const SizedBox.shrink();
    return bloc.isEditable ? Future.value(false) : Future.value(true);
  }
}

class ClaimDraftProductInfoContent extends StatelessWidget {
  final ClaimDraftProductBloc bloc;
  final ClaimDraftsProductsData data;

  ClaimDraftProductInfoContent({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(kBasePadding),
        children: [
          const SizedBox(height: kPadding),
          Text(
            data.productName,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: kPadding),
          WidgetOrNullRowHelper(
            title: '${S.of(context).series}: ',
            value: data.seriesName,
            titleStyle:
                Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 16),
            valueStyle:
                Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 16),
          ),
          _invoicesQuantity(context),
          Text(
            S.of(context).claim_quantity,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          ClaimDraftProductQuantityField(bloc: bloc),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).claim_type,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          ClaimDraftProductSelectorField(bloc: bloc, data: data),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).comment,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          ClaimDraftProductCommentField(bloc: bloc),
          const SizedBox(height: kPadding * 3),
          Text(
            'Файлы',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: kPadding,
          ),
          ClaimDraftProductFiles(bloc: bloc, data: data),
        ],
      ),
    );
  }

  Widget _invoicesQuantity(BuildContext context) {
    if (data.invoiceQuantity != 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: kPadding * 3),
        child: WidgetOrNullColumnHelper(
          needPadding: false,
          title: S.of(context).invoice_quantity,
          value: data.invoiceQuantity.toString(),
        ),
      );
    }
    return const SizedBox(height: kPadding * 3);
  }
}
