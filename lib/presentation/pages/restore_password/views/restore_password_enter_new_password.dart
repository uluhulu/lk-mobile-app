import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:super_validation/validation_builder.dart';
import '../../../widgets/ui/title_subtitle_widget.dart';
import '../restore_password_bloc/restore_password_bloc.dart';
import '../widgets/fields/restore_password_enter_text_field.dart';
import '../widgets/fields/restore_password_re_enter_text_field.dart';

class RestorePasswordEnterNewPassword extends StatelessWidget {
  const RestorePasswordEnterNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MyTheme.of(context);
    final bloc = context.read<RestorePasswordBloc>();
    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        Text(S.of(context).registration_data,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: kBasePadding),
        TitleSubtitleWidget(
          title: S.of(context).login,
          subtitle: bloc.login.text,
        ),
        const SizedBox(height: kBasePadding),
        TitleSubtitleWidget(
          title: S.of(context).region_company,
          subtitle: bloc.getName(bloc.filialValidation.value ?? 0),
        ),
        const SizedBox(height: kBasePadding * 2),
        Container(
            padding: const EdgeInsets.only(
              top: kCardPadding,
              bottom: kBasePadding,
              right: kCardPadding,
              left: kCardPadding,
            ),
            decoration: BoxDecoration(
                color: colors.blueColor,
                borderRadius: BorderRadius.circular(kBorderRadius)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icon/danger.svg',
                  color: colors.whiteColor,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: kPadding),
                Expanded(
                  child: Text(
                    S.of(context).reset_password_info,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: colors.whiteColor,
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            )),
        const SizedBox(height: kPadding * 3),
        Text(S.of(context).new_password,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        RestorePasswordEnterTextField(
          obscureText: true,
          altValidation: bloc.passwordValid,
          passwordValidation: bloc.password,
        ),
        const SizedBox(height: kPadding * 3),
        Text(S.of(context).confirm_password,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        RestorePasswordReEnterField(
          obscureText: true,
          altValidation: bloc.reEnterPasswordValid,
          passwordValidation: bloc.reEnterPassword,
        ),
        const SizedBox(height: kPadding * 3),
        SuperValidationMultiBuilder(
            superValidation: {'password': bloc.reEnterPassword},
            builder: (context, validation, isValid) {
              return PrimaryElevatedButton(
                  canPress: isValid,
                  onPressed: () {
                    bloc.add(RestorePasswordResetE());
                  },
                  text: S.of(context).change_password);
            }),
        const SizedBox(height: kPadding),
      ],
    );
  }
}
