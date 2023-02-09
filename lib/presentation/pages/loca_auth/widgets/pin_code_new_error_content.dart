import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../authorization/authorization_bloc/authorization_bloc.dart';

class PinCodeNewErrorContent extends StatelessWidget {
  final bool isSetPin;
  const PinCodeNewErrorContent({
    super.key,
    required this.isSetPin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: _padding(),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              'assets/icon/info-circle.svg',
              width: 36,
              height: 36,
              color: Colors.red,
            ),
            const SizedBox(height: kBasePadding),
            isSetPin == false
                ? Text(
                    S.of(context).local_auth_error,
                    style: Theme.of(context).textTheme.headline2,
                  )
                : Text(
                    S.of(context).change_code_error_title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
          ],
        ),
        const SizedBox(height: kBasePadding),
        isSetPin == false
            ? Text(
                'Вы неверно ввели код 3 раза подряд.\n\nВам нужно войти в приложение заново по логину и паролю.',
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Text(
                S.of(context).change_code_error_subtitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
        const SizedBox(height: kBasePadding),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            //context.read<AuthorizationBloc>().isEnterForLogin = 0;
            context.read<AuthorizationBloc>().add(AuthorizationNewLocalAuthE());

            context.read<BannerBloc>().add(BannerInitializeE());
          },
          text: 'Войти по логину',
        ),
        const SizedBox(height: kPadding * 3),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}
