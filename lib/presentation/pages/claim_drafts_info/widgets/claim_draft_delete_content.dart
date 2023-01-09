import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../claim_drafts_bloc/claim_drafts_info_bloc.dart';

class ClaimDraftDeleteContent extends StatelessWidget {
  final int id;
  const ClaimDraftDeleteContent({
    super.key,
    required this.id,
  });

//TODO: intl and refactoring
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kBasePadding),
          Text(S.of(context).delete_claim_draft,
              style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: kBasePadding),
          Text(S.of(context).delete_claim_draft_info,
              style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: kBasePadding * 3),
          PrimaryElevatedButton(
            onPressed: () {
              context.read<ClaimDraftsInfoBloc>().add(ClaimDraftsInfoDeleteE());

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset('assets/icon/trash_empty.svg',
                width: 24, height: 24, color: MyTheme.of(context).whiteColor),
            text: S.of(context).delete,
          ),
          const SizedBox(height: kPadding * 3),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(S.of(context).canc,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: MyTheme.of(context).primaryButtonColor)),
              )),
          const SizedBox(height: kPadding * 3),
        ],
      ),
    );
  }
}
