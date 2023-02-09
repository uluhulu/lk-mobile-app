import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_add_overage/invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/services/platform.dart';
import 'package:super_validation/validation_builder.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/buttons/primary_elevated_button.dart';
import 'invoice_overage_product_delete_content.dart';

class InvoiceOverageProductNavBar extends StatelessWidget {
  final int id;
  const InvoiceOverageProductNavBar({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      decoration: _decoration(),
      child: Column(
        children: [
          Row(
            children: [
              CreateClaimDeleteButton(id: id, myColors: myColors),
              const SizedBox(width: kBasePadding),
              CreateClaimSaveButton(id: id, myColors: myColors),
            ],
          ),
          isIOS()
              ? const SizedBox(height: kBasePadding)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.09),
          spreadRadius: 0,
          blurRadius: 20,
          offset: const Offset(0, -1),
        ),
      ],
    );
  }
}

class CreateClaimSaveButton extends StatelessWidget {
  const CreateClaimSaveButton({
    Key? key,
    required this.id,
    required this.myColors,
  }) : super(key: key);

  final int id;
  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<InvoiceAddOverageBloc>(context);
    return Expanded(
      child: SuperValidationBuilder(
          superValidation: bloc.quantityClaim,
          builder: (context, validation, isValid) {
            return PrimaryElevatedButton(
              canPress: isValid,
              onPressed: () {
                bloc.add(InvoiceAddOverageSaveProductE());
              },
              text: S.of(context).save,
            );
          }),
    );
  }
}

class CreateClaimDeleteButton extends StatelessWidget {
  const CreateClaimDeleteButton({
    Key? key,
    required this.myColors,
    required this.id,
  }) : super(key: key);

  final int id;
  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<InvoiceAddOverageBloc>(context);
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: TextButton(
        onPressed: () {
          BaseBottomSheetWidget(
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: InvoiceOverageProductDeleteContent(id: id),
            ),
          ).show();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 29),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(width),
            const SizedBox(width: kPadding),
            _btText(context, width),
          ],
        ),
      ),
    );
  }

  Widget _btText(BuildContext context, double width) {
    return Text(
      S.of(context).delete_product,
      style: Theme.of(context).textTheme.headline4?.copyWith(
          color: myColors.errorColor, fontSize: width < 322 ? 15 : null),
    );
  }

  Widget _icon(double width) {
    return SvgPicture.asset(
      'assets/icon/trash_empty.svg',
      color: myColors.errorColor,
      width: width < 322 ? 22 : 24,
      height: width < 322 ? 22 : 24,
    );
  }
}