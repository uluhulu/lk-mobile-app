import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/widgets/add_product/add_product_claim_type_list.dart';
import 'package:mkk/presentation/widgets/fields/custom_input_decoration.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_row_helper.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../../../widgets/image_picker/attachments_load_error.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../../widgets/image_picker/custom_image_picker.dart';
import '../../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../../widgets/add_product/add_product_nav_bar.dart';

class AddProductInfoPage extends StatefulWidget {
  final ClaimDraftsProductsData data;

  const AddProductInfoPage({
    super.key,
    required this.data,
  });

  @override
  State<AddProductInfoPage> createState() => _AddProductInfoPageState();
}

class _AddProductInfoPageState extends State<AddProductInfoPage> {
  late ClaimDraftAddProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ClaimDraftAddProductBloc>();
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
            AddProductNavBar(id: widget.data.id),
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
          const SizedBox(height: kPadding * 3),
          WidgetOrNullColumnHelper(
            needPadding: false,
            title: S.of(context).invoice_quantity,
            value: widget.data.invoiceQuantity.toString(),
          ),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).claim_quantity,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          TextFieldSuperValidationWithIcon(
            errorIcon: const ErrorIconWidget(),
            superValidation: bloc.quantityClaim,
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
          _claimTypeSelector(),
          const SizedBox(height: kPadding * 3),
          Text(
            S.of(context).comment,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          _commentField(myColors, context),
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
                      productId: widget.data.id,
                      context: context,
                    ),
                    addImageFromGallery: () => cubit.updateClaimDraftImages(
                      fromGallery: true,
                      claimId: bloc.draftId,
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

  Widget _claimTypeSelector() {
    return SuperValidationEnumBuilder<String?>(
      superValidation: bloc.claimType,
      builder: _claimTypeSelectorBuilder,
    );
  }

  Widget _claimTypeSelectorBuilder(BuildContext context, String? value) {
    return SuperValidationTextFieldListener(
      superValidation: bloc.claimType,
      transformer: (value) => value ?? '',
      maxLines: 5,
      minLines: 1,
      readOnly: true,
      onTap: () {
        BaseBottomSheetWidget(
          context: context,
          child: BlocProvider.value(
            value: bloc,
            child: AddProductClaimTypeList(
              claimTypeData: widget.data.possibleClaimTypes ?? {},
            ),
          ),
        ).show();
      },
      decoration: _claimTypeSelectorDecoration(context),
    );
  }

  CustomInputDecoration _claimTypeSelectorDecoration(BuildContext context) {
    return CustomInputDecoration(
      needOtherFocusColor: true,
      hintText: S.of(context).not_selected,
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).greyIconColor,
      ),
    );
  }
}
