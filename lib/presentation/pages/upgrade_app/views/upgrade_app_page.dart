import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../widgets/scaffold/status_bar_settings.dart';
import '../upgrade_app_bloc/upgrader_bloc.dart';
import '../widgets/upgrader_icon.dart';
import '../widgets/upgrader_text.dart';
import '../widgets/upgrader_title.dart';

class UpgradeAppPage extends StatelessWidget {
  const UpgradeAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).primaryButtonColor,
      appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: SvgPicture.asset('assets/icon/app_bar_logo.svg'),
          // title: Text("Вася вОНЯЕТ"),
          elevation: 0,
          systemOverlayStyle: StatusBarSettings.settings(context)),
      body: const UpgradeAppContent(),
    );
  }
}

class UpgradeAppContent extends StatelessWidget {
  const UpgradeAppContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final bloc = BlocProvider.of<UpgraderBloc>(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UpgraderIcon(),
          const SizedBox(
            height: kPadding,
          ),
          UpgraderTitle(
            textColor: theme.whiteColor,
          ),
          const SizedBox(
            height: kBasePadding,
          ),
          UpgraderText(
            textColor: theme.whiteColor,
          ),
          const SizedBox(
            height: kPadding * 5,
          ),
          PrimaryElevatedButton(
            onPressed: () {
              bloc.add(UpgraderLaunchUrlE());
            },
            btnWidth: 128,
            btnHeight: 40,
            backgroundColor: theme.whiteColor,
            // color: theme.primaryButtonColor,
            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: theme.primaryButtonColor,
                  fontWeight: FontWeight.w600,
                ),
            text: S.of(context).update,
          ),
        ],
      ),
    );
  }
}
