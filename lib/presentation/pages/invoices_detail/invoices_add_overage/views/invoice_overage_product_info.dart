import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_add_overage/invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import 'package:mkk/presentation/widgets/fields/custom_input_decoration.dart';
import 'package:mkk/presentation/widgets/fields/error_icon_widget.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_row_helper.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../widgets/image_picker/attachments_load_error.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../../widgets/image_picker/custom_image_picker.dart';
import '../../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../widgets/product_detail/invoice_overage_product_nav_bar.dart';

class InvoiceOverageProductInfo extends StatefulWidget {
  final ClaimDraftsProductsData data;
  final int draftId;
  final List<ClaimDraftFile> attachments;

  const InvoiceOverageProductInfo({
    super.key,
    required this.data,
    required this.attachments,
    required this.draftId,
  });

  @override
  State<InvoiceOverageProductInfo> createState() =>
      _InvoiceOverageProductInfoState();
}

class _InvoiceOverageProductInfoState extends State<InvoiceOverageProductInfo> {
  late InvoiceAddOverageBloc bloc;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    bloc = context.read<InvoiceAddOverageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);

    return ScreenView(
        context: context,
        needPadding: false,
        title: S.of(context).claim_draft,
        child: Column(
          children: [
            _content(context, myColors),
            InvoiceOverageProductNavBar(id: widget.data.id),
          ],
        ));
  }

  Widget _content(BuildContext context, MyThemeData myColors) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(kBasePadding),
        children: [
          const SizedBox(height: kPadding),
          Text(
            widget.data.productName,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: kPadding),
          WidgetOrNullRowHelper(
            title: '${S.of(context).series}: ',
            value: widget.data.seriesName,
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
          TextFieldSuperValidationWithIcon(
            superValidation: bloc.quantityClaim,
            errorIcon: const ErrorIconWidget(),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: CustomInputDecoration(
              myColors: myColors,
              hintText: '0',
            ),
          ),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).claim_type,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          _inactiveField(context),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).comment,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          _commentField(myColors, context),

          ///TODO ДОБАВЛЕНИЕ ФАЙЛОВ
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
                      claimId: widget.draftId,
                      productId: widget.data.id,
                      context: context,
                    ),
                    addImageFromGallery: () => cubit.updateClaimDraftImages(
                      fromGallery: true,
                      claimId: widget.draftId,
                      productId: widget.data.id,
                      context: context,
                    ),
                  ),
                  claimDraftFileItems: state.attachment,
                  showPicker: true,
                  isDeleted: true,
                  onDeleteClaimFile: (file) => {},
                  claimFile: [],
                  onDeleteClaimDraftFile: (ClaimDraftFile image) =>
                      cubit.deleteImage(id: image.id),
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
    if (widget.data.invoiceQuantity != 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: kPadding * 3),
        child: WidgetOrNullColumnHelper(
          needPadding: false,
          title: S.of(context).invoice_quantity,
          value: widget.data.invoiceQuantity.toString(),
        ),
      );
    }
    return const SizedBox(height: kPadding * 3);
  }

  Widget _commentField(MyThemeData myColors, BuildContext context) {
    return TextFieldSuperValidation(
      superValidation: bloc.comment,
      decoration: CustomInputDecoration(
        myColors: myColors,
        hintText: S.of(context).briefly_describe_the_situation,
      ),
      maxLines: 10,
      minLines: 2,
      maxLength: 200,
      scrollPadding: const EdgeInsets.only(bottom: kBasePadding * 5),
    );
  }

  Widget _inactiveField(BuildContext context) {
    return TextField(
      decoration: _overdueDecoration(context),
      readOnly: true,
      enabled: true,
    );
  }

  CustomInputDecoration _overdueDecoration(BuildContext context) {
    return CustomInputDecoration(
      filled: true,
      needOtherFocusColor: true,
      otherEnabledColor: true,
      hintText: 'Излишки',
      hintStyle: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Colors.grey.shade700),
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).hintColor.withOpacity(0.5),
      ),
    );
  }
}
