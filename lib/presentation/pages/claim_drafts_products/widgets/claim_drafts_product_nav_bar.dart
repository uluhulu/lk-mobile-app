import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/services/platform.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../claim_drafts_info/widgets/bottom_sheet/claim_draft_send_content.dart';
import 'claim_drafts_product_delete_content.dart';

class ClaimDraftProductNavBar extends StatelessWidget {
  final int id;
  const ClaimDraftProductNavBar({
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
              ClaimDraftDeleteButton(id: id, myColors: myColors),
              const SizedBox(width: kBasePadding),
              ClaimDraftSaveButton(id: id, myColors: myColors),
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

class ClaimDraftSaveButton extends StatelessWidget {
  const ClaimDraftSaveButton({
    Key? key,
    required this.id,
    required this.myColors,
  }) : super(key: key);

  final int id;
  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PrimaryElevatedButton(
        onPressed: () {
          context
              .read<ClaimDraftsProductsBloc>()
              .add(ClaimDraftsProductsSaveE(productId: id));

          Navigator.of(context).pop();
        },
        text: S.of(context).save,
      ),
    );
  }
}

class ClaimDraftDeleteButton extends StatelessWidget {
  final int id;
  const ClaimDraftDeleteButton({
    Key? key,
    required this.myColors,
    required this.id,
  }) : super(key: key);

  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftsProductsBloc>();
    return Expanded(
      child: TextButton(
        onPressed: () {
          BaseBottomSheetWidget(
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: ClaimDraftProductDeleteContent(id: id),
            ),
          ).show();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 29),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(width: kPadding),
            _btText(context),
          ],
        ),
      ),
    );
  }

  Widget _btText(BuildContext context) {
    return Text(
      'Удалить товар',
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: myColors.errorColor,
          ),
    );
  }

  Widget _icon() {
    return SvgPicture.asset(
      'assets/icon/trash_empty.svg',
      color: myColors.errorColor,
      width: 24,
      height: 24,
    );
  }
}
