import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class ClaimDraftProductDeleteContent extends StatelessWidget {
  final int id;
  const ClaimDraftProductDeleteContent({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: kBasePadding * 2,
          left: kBasePadding,
          right: kBasePadding,
          bottom: kBottomSheetBottomPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Удаление товара',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              'Товар будет удалён из черновика претензии, вы уверены?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context
                    .read<ClaimDraftsProductsBloc>()
                    .add(ClaimDraftsProductsDeleteE(id: id));
              },
              icon: SvgPicture.asset(
                'assets/icon/trash_empty.svg',
                width: 24,
                height: 24,
                color: MyTheme.of(context).whiteColor,
              ),
              text: S.of(context).delete,
            ),
            const SizedBox(height: kBasePadding),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: kBasePadding * 2),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: Text('Отмена',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: MyTheme.of(context).primaryColor,
                      )),
            )
          ],
        ));
  }
}
