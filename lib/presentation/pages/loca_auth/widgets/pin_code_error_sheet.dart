import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/loca_auth/local_auth_bloc/local_auth_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../banner/banner_bloc/banner_bloc.dart';

class PinCodeErrorSheet extends StatelessWidget {
  final bool isSetPin;
  final bool isFirstSetPin;
  const PinCodeErrorSheet({
    super.key,
    required this.isSetPin,
    required this.isFirstSetPin,
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
            _titleTextWithPinCode(context),
          ],
        ),
        const SizedBox(height: kBasePadding),
        _subtitleTextWithPinCode(context),
        const SizedBox(height: kBasePadding),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<LocalAuthBloc>().add(LocalAuthInitializeE());
          },
          text: S.of(context).create_new_code,
        ),
        const SizedBox(height: kPadding * 3),
        _buildButtonWithPinCode(context),
        const SizedBox(height: kPadding * 3),
      ],
    );
  }

  Widget _titleTextWithPinCode(BuildContext context) {
    if (isSetPin && !isFirstSetPin) {
      return Text(
        S.of(context).pin_code_error_title,
        style: Theme.of(context).textTheme.headline2,
      );
    } else if (isSetPin) {
      return Text(
        S.of(context).change_code_error_title,
        style: Theme.of(context).textTheme.headline2,
      );
    }
    return Text(
      S.of(context).change_code_error_title,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget _subtitleTextWithPinCode(BuildContext context) {
    if (isSetPin && !isFirstSetPin) {
      return Text(
        S.of(context).pin_code_error_subtitle_new,
        style: Theme.of(context).textTheme.bodyText1,
      );
    } else if (isSetPin) {
      return Text(
        S.of(context).change_code_error_subtitle,
        style: Theme.of(context).textTheme.bodyText1,
      );
    }
    return Text(
      S.of(context).pin_code_error_subtitle,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _buildButtonWithPinCode(BuildContext context) {
    if (isSetPin && !isFirstSetPin) {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text(
          S.of(context).cancel,
        ),
      );
    } else if (isSetPin) {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text(
          S.of(context).leave_old_code,
        ),
      );
    }
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        context.read<BannerBloc>().add(BannerSetPinShowedE());
      },
      child: Text(S.of(context).skip_create_code),
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
