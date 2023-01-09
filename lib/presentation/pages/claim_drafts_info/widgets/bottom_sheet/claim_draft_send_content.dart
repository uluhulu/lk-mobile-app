import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';

class ClaimDraftSendContent extends StatelessWidget {
  const ClaimDraftSendContent({super.key});

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
              'Отправка претензии',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kBasePadding),
            Text(
              'Вы действительно хотите отправить черновик претензии?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<ClaimDraftsInfoBloc>().add(ClaimDraftsInfoSendE());
              },
              text: S.of(context).send,
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
              child: Text(S.of(context).cancel,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: MyTheme.of(context).primaryColor,
                      )),
            )
          ],
        ));
  }
}
