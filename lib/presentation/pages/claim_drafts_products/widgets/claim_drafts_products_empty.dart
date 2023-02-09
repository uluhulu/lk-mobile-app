import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../services/platform.dart';
import '../../claim_drafts_info/widgets/claim_draft_delete_button.dart';
import '../../claim_drafts_info/widgets/claim_draft_row_buttons.dart';

class ClaimDraftsProductsEmpty extends StatelessWidget {
  final int draftId;
  const ClaimDraftsProductsEmpty({
    Key? key,
    required this.draftId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClaimDraftRowButtons(draftId: draftId),
        const SizedBox(height: kBasePadding),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 230),
          child: Lottie.asset(
            'assets/lottie/searching_animation.json',
          ),
        ),
        const SizedBox(height: kPadding),
        Text(
          S.of(context).select_product_two,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: MyTheme.of(context).greyIconColor),
        ),
        const SizedBox(height: kBasePadding),
        const Divider(),
        const SizedBox(height: kPadding),
        ClaimDraftDeleteButton(id: draftId),
        isAndroid()
            ? const SizedBox(height: kBasePadding)
            : const SizedBox.shrink(),
      ],
    );
  }
}
