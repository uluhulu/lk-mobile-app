import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_draft_product_bloc/claim_draft_product_cubit.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_row_helper.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../widgets/image_picker/attachments_load_error.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../widgets/image_picker/custom_image_picker.dart';
import '../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../widgets/fields/claim_draft_product_coment_field.dart';
import '../widgets/fields/claim_draft_product_quantity_field.dart';
import '../widgets/fields/claim_draft_product_selector_field.dart';

class ClaimDraftProductInfoContent extends StatelessWidget {
  final ClaimDraftProductBloc bloc;
  final ClaimDraftsProductsData data;

  const ClaimDraftProductInfoContent({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          //TODO Добавление Файлов
          const SizedBox(height: kPadding * 3),
          Text(
            'Файлы',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: kPadding,
          ),
          BlocBuilder<ClaimsFilesCubit, ClaimsFileState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
              if (state is ClaimsFileLoadingS) {
                return const LoadingWidget();
              }
              if (state is ClaimDraftFileLoadedS) {
                return CustomImageAndFilesPicker(
                  onAddButton: () => showCustomDialog(
                    context: context,
                    addImageFromCamera: () => cubit.updateClaimDraftImages(
                      fromGallery: false,
                      claimId: bloc.draftId,
                      productId: data.id,
                      context: context,
                    ),
                    addImageFromGallery: () => cubit.updateClaimDraftImages(
                      fromGallery: true,
                      claimId: bloc.draftId,
                      productId: data.id,
                      context: context,
                    ),
                  ),
                  claimDraftFileItems: state.attachment,
                  showPicker: true,
                  isDeleted: true,
                  onDeleteClaimFile: (file) => {},
                  claimFile: [],
                  onDeleteClaimDraftFile: (ClaimDraftFile image) => {
                    cubit.deleteImage(id: image.id),
                  },
                );
              }
              if (state is ClaimsFileErrorS) {
                return const AttachmentLoadError();
              }

              return const SizedBox();
            },
          ),
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
