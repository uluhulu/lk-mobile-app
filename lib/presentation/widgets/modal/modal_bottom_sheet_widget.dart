import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/locator/locator.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../core/help/launch_url_helper.dart';
import '../../../core/utils/constants.dart';
import '../../../generated/l10n.dart';
import '../../../services/appmetrica/appmetrica_service.dart';
import '../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../buttons/secondary_elevated_button.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  const ModalBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        ModalBottomSheetContent(),
        DragHandleWidget(),
        ModalBottomSheetIconBackWidget(),
      ],
    );
  }
}

class ModalBottomSheetIconBackWidget extends StatelessWidget {
  const ModalBottomSheetIconBackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        iconSize: 40,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/icon/close.svg',
          width: 40,
          height: 40,
          color: MyTheme.of(context).greyIconColor,
        ),
      ),
    );
  }
}

class DragHandleWidget extends StatelessWidget {
  const DragHandleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -18,
      right: 0,
      left: 0,
      child: IconButton(
        iconSize: 32,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/icon/drag_handle.svg',
          width: 32,
          height: 3,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBottomSheetBottomPadding,
      ),
      shrinkWrap: true,
      children: [
        Text(
          S.of(context).register,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: kBasePadding),
        Text(
          S.of(context).register_info,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: kBasePadding * 3),
        BlocProvider<AppMetricaBloc>(
          create: (context) => AppMetricaBloc(
            appMetricaService: sl.get<AppMetricaService>(),
          ),
          child: BlocBuilder<AppMetricaBloc, AppMetricaState>(
            builder: (context, state) {
              final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
              return SecondaryElevatedButton(
                onPressed: () {
                  LaunchUrlHelper.launchURL(
                    'https://puls.ru/',
                  );
                  appMetricaBloc.add(AppmetricaOnEventE(
                      eventName:
                          "Экран регистрации ${S.of(context).button_on_pressed} ${S.of(context).open_web_puls}"));
                  Navigator.of(context).pop();
                },
                text: S.of(context).open_web_puls,
              );
            },
          ),
        )
      ],
    );
  }
}
