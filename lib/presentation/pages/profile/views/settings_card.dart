import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../domain/use_cases/user/local_auth_use_case.dart';
import '../../../../generated/l10n.dart';
import '../../authorization/authorization_bloc/authorization_bloc.dart';
import '../../banner/banner_bloc/banner_bloc.dart';
import '../widgets/notification_content.dart';
import '../widgets/settings_item_widget.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
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
        SettingsItemWidget(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.setPin);
          },
          title: _isSetPin(context)
              ? S.of(context).change_app_login_code
              : "Установить код входа в приложение",
          icon: SvgPicture.asset('assets/icon/key.svg',
              color: Theme.of(context).primaryColor),
          needDivider: false,
        ),

        // SettingsItemWidget(
        //   onPressed: () {
        //     context.read<BannerBloc>().add(BannerRemoveAllE());
        //   },
        //   title: 'Удалить данные о пин коде',
        //   needIconNext: false,
        //   icon: SvgPicture.asset('assets/icon/key.svg',
        //       color: Theme.of(context).primaryColor),
        //   needDivider: false,
        // ),
        Divider(
          thickness: 12,
          color: MyTheme.of(context).mainDividerColor,
        ),
        SettingsItemWidget(
          onPressed: () {
            context.read<AuthorizationBloc>().add(AuthorizationLogOutE());
          },
          title: S.of(context).logout,
          icon: SvgPicture.asset('assets/icon/logout.svg',
              color: myColors.errorColor),
          needIconNext: false,
          needDivider: false,
        ),
      ],
    );
  }

  BaseBottomSheetWidget notificationCenter(BuildContext context) {
    return BaseBottomSheetWidget(
      context: context,
      child: const NotificationContentWidget(),
    )..show();
  }

  bool _isSetPin(BuildContext context) {
    final userRepo = sl.get<UserRepository>();
    final localAuth = GetLocalAuthUseCase(userRepo);
    final pinCode = localAuth.call();
    return pinCode?.isNotEmpty ?? false ? true : false;
  }
}
