import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/upgrade_app/widgets/upgrader_icon.dart';
import 'package:mkk/presentation/pages/upgrade_app/widgets/upgrader_text.dart';
import 'package:mkk/presentation/pages/upgrade_app/widgets/upgrader_title.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../upgrade_app_bloc/upgrader_bloc.dart';

class UpgraderBottomSheetContent extends StatelessWidget {
  const UpgraderBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final theme = MyTheme.of(context);
     final bloc = BlocProvider.of<UpgraderBloc>(context);
     return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(kBasePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: kBasePadding,
            ),
            const UpgraderIcon(),
            const SizedBox(
              height: kPadding,
            ),
            UpgraderTitle(textColor: theme.blackColor,),
            const SizedBox(
              height: kBasePadding,
            ),
            UpgraderText(textColor: theme.blackColor,),
            const SizedBox(
              height: kPadding * 5,
            ),
            PrimaryElevatedButton(
              onPressed: () {
                bloc.add(UpgraderLaunchUrlE());
              },
              btnHeight: 48,
              text: S.of(context).update,
            ),
            const SizedBox(
              height: kBottomSheetBottomPadding,
            ),
          ],
        ),
      ),
    );
  }
}
