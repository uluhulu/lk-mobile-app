import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/providers/dio/transformers/interceptors/dio_auth_synchronizer.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../../../blocs/settings_cubit/settings_cubit.dart';
import '../../authorization/authorization_bloc/authorization_bloc.dart';
import '../../loca_auth/local_auth_bloc/local_auth_bloc.dart';
import '../widgets/notification_content.dart';
import '../widgets/settings_item_widget.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return BlocBuilder<AppMetricaBloc, AppMetricaState>(
        builder: (context, state) {
      final bloc = BlocProvider.of<AppMetricaBloc>(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kBasePadding),
            child: Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: kPadding),
          // SettingsItemWidget(
          //   onPressed: () {
          //     notificationCenter(context);
          //   },
          //   title: S.of(context).notifications,
          //   icon: SvgPicture.asset('assets/icon/notification.svg',
          //       color: Theme.of(context).primaryColor),
          // ),
          BlocBuilder<LocalAuthBloc, LocalAuthState>(
            builder: (context, state) {
              return SettingsItemWidget(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.setPin);
                  _isSetPin(context, state)
                      ? bloc.add(AppmetricaOnEventE(
                          eventName:
                              "Главный Экран ${S.of(context).button_on_pressed} ${S.of(context).change_app_login_code}"))
                      : () {};
                },
                title: _isSetPin(context, state)
                    ? S.of(context).change_app_login_code
                    : S.of(context).set_app_code,
                icon: SvgPicture.asset('assets/icon/key.svg',
                    color: Theme.of(context).primaryColor),
                needDivider: true,
              );
            },
          ),
          // SettingsItemWidget(
          //   onPressed: () {
          //     sl.get<AuthSynchronizer>().test();
          //   },
          //   title: 'test',
          //   icon: SvgPicture.asset('assets/icon/key.svg',
          //       color: Theme.of(context).primaryColor),
          //   needDivider: true,
          // ),
          // Divider(
          //   indent: 56,
          //   color: MyTheme.of(context).mainDividerColor,
          // ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SettingsItemWidget(
                  onPressed: () {},
                  title: 'Сохранять фото в галерею',
                  icon: SvgPicture.asset('assets/icon/gallery.svg',
                      color: Theme.of(context).primaryColor),
                  needDivider: false,
                  needIconNext: false,
                  widget: SizedBox(
                    height: 20,
                    width: 50,
                    child: Switch.adaptive(
                      value: state.savePhoto,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setSavePhoto(value);
                      },
                      activeColor: myColors.primaryColor,
                    ),
                  ));
            },
          ),
          Divider(
            thickness: 12,
            color: MyTheme.of(context).mainDividerColor,
          ),
          SettingsItemWidget(
            onPressed: () {
              context.read<AuthorizationBloc>().add(AuthorizationLogOutE());
              bloc.add(
                AppmetricaOnEventE(
                    eventName:
                        "Главный Экран ${S.of(context).button_on_pressed} ${S.of(context).logout}"),
              );
            },
            title: S.of(context).logout,
            icon: SvgPicture.asset('assets/icon/logout.svg',
                color: myColors.errorColor),
            needIconNext: false,
            needDivider: false,
          ),
        ],
      );
    });
  }

  BaseBottomSheetWidget notificationCenter(BuildContext context) {
    return BaseBottomSheetWidget(
      context: context,
      child: const NotificationContentWidget(),
    )..show();
  }

  bool _isSetPin(BuildContext context, LocalAuthState state) {
    if (state is LocalAuthSuccessS) {
      return sl.get<UserRepository>().getLocalAuthPin() != null;
    } else {
      return sl.get<UserRepository>().getLocalAuthPin() != null;
    }
  }
}
