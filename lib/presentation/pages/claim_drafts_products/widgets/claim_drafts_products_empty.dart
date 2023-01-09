import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/theme/elements/theme_data.dart';

class ClaimDraftsProductsEmpty extends StatelessWidget {
  const ClaimDraftsProductsEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: kBasePadding),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 230),
          child: Lottie.asset(
            'assets/lottie/searching_animation.json',
          ),
        ),
        const SizedBox(height: kPadding),
        //TODO: intl
        Text('Выберите товары из накладной или добавьте излишки',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: MyTheme.of(context).greyIconColor)),
      ],
    );
  }
}
