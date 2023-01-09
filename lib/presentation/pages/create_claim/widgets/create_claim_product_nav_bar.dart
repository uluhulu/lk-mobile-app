import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/services/platform.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../claim_drafts_products/widgets/claim_drafts_product_delete_content.dart';
import '../create_claim_bloc/create_claim_bloc.dart';
import 'create_claim_product_delete_content.dart';
import 'create_claim_product_save_content.dart';

class CreateClaimProductNavBar extends StatelessWidget {
  final int id;
  const CreateClaimProductNavBar({
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
    final bloc = BlocProvider.of<CreateClaimBloc>(context);
    return Expanded(
      child: PrimaryElevatedButton(
        onPressed: () {
          bloc.add(CreateClaimSaveE());
          // BaseBottomSheetWidget(
          //   context: context,
          //   child: BlocProvider.value(
          //     value: bloc,
          //     child: CreateClaimProductSaveContent(id: id),
          //   ),
          // ).show();
        },
        text: S.of(context).save,
      ),
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
    final bloc = context.read<CreateClaimBloc>();
    return Expanded(
      child: TextButton(
        onPressed: () {
          BaseBottomSheetWidget(
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: CreateClaimProductDeleteContent(id: id),
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
