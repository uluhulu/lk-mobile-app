import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../create_claim_bloc/create_claim_bloc.dart';

class CreateClaimProductSaveContent extends StatelessWidget {
  final int id;
  const CreateClaimProductSaveContent({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Сохранить изменения?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kBasePadding * 3),
            PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context
                    .read<CreateClaimBloc>()
                    .add(CreateClaimDeleteProductE(id: id));
              },
              text: S.of(context).save,
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
              child: Text('Не сохранять',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: MyTheme.of(context).primaryColor,
                      )),
            )
          ],
        ));
  }
}
