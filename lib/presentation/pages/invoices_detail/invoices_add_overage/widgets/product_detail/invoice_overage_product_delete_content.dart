import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_add_overage/invoice_add_overage_bloc/invoice_add_overage_bloc.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/buttons/primary_elevated_button.dart';

class InvoiceOverageProductDeleteContent extends StatelessWidget {
  final int id;
  const InvoiceOverageProductDeleteContent({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).product_deletion,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              S.of(context).product_deletion_confirmation,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: kBasePadding * 3),
            _deleteButton(context),
            const SizedBox(height: kBasePadding),
            _cancelButton(context)
          ],
        ));
  }

  Widget _deleteButton(BuildContext context) {
    return PrimaryElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        context
            .read<InvoiceAddOverageBloc>()
            .add(InvoiceAddOverageDeleteProductE(id: id));
      },
      icon: SvgPicture.asset(
        'assets/icon/trash_empty.svg',
        width: 24,
        height: 24,
        color: MyTheme.of(context).whiteColor,
      ),
      text: S.of(context).delete,
    );
  }

  Widget _cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: kBasePadding * 2),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: Text(
        S.of(context).canc,
        style: Theme.of(context).textTheme.headline4?.copyWith(
              color: MyTheme.of(context).primaryColor,
            ),
      ),
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}
