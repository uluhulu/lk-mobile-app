import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';
import '../../authorization/authorization_bloc/authorization_bloc.dart';
import '../../banner/banner_bloc/banner_bloc.dart';
import '../widgets/settings_icon_title_widget.dart';

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
        const SizedBox(height: kBasePadding * 2),
        SettingsIconTitleWidget(
          icon: SvgPicture.asset(
            'assets/icon/notification.svg',
            color: Theme.of(context).primaryColor,
          ),
          title: S.of(context).notifications,
          onPressed: () {
            notificationCenter(context);
          },
        ),
        const Divider(
          height: 64,
          thickness: 2,
          indent: 40,
        ),
        SettingsIconTitleWidget(
          icon: SvgPicture.asset(
            'assets/icon/key.svg',
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.setPin);
          },
          title: S.of(context).change_app_login_code,
        ),
        const Divider(
          height: 64,
          thickness: 2,
          indent: 40,
        ),
        SettingsIconTitleWidget(
          icon: SvgPicture.asset(
            'assets/icon/key.svg',
            color: Theme.of(context).primaryColor,
          ),
          title: 'Удалить данные о пин коде',
          needIconNext: false,
          onPressed: () {
            context.read<BannerBloc>().add(BannerRemoveAllE());
          },
        ),
        const SizedBox(height: kPadding * 2),
        const Divider(
          height: 48,
          thickness: 12,
        ),
        const SizedBox(height: kBasePadding),
        SettingsIconTitleWidget(
          icon: SvgPicture.asset(
            'assets/icon/logout.svg',
            color: myColors.errorColor,
          ),
          title: S.of(context).logout,
          needIconNext: false,
          onPressed: () {
            context.read<AuthorizationBloc>().add(AuthorizationLogOutE());
          },
        ),
        const SizedBox(height: kBasePadding * 2),
      ],
    );
  }

  BaseBottomSheetWidget notificationCenter(BuildContext context) {
    return BaseBottomSheetWidget(
        context: context, child: const NotificationContentWidget())
      ..show();
  }
}

class NotificationContentWidget extends StatelessWidget {
  const NotificationContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return ListView(
      padding: const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBottomSheetBottomPadding,
      ),
      shrinkWrap: true,
      children: [
        Text(S.of(context).notifications,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: kBasePadding),
        Text('Выберите события, о которых вы хотите получать уведомления',
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: kPadding * 3),
        CheckboxListTile(
          value: true,
          side: BorderSide(width: 1, color: myColors.greyIconColor),
          activeColor: myColors.primaryButtonColor,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
          ),
          contentPadding: EdgeInsets.zero,
          onChanged: (value) {},
          title: Text('Изменения статусов претензий',
              style: Theme.of(context).textTheme.bodyText1),
        ),
        const Divider(
          height: 40,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        CheckboxListTile(
          value: false,
          side: BorderSide(width: 1, color: myColors.greyIconColor),
          contentPadding: EdgeInsets.zero,
          onChanged: (value) {},
          title: Text('Сообщения по претензиям',
              style: Theme.of(context).textTheme.bodyText1),
        ),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(onPressed: () {}, text: 'Сохранить'),
        const SizedBox(height: kPadding * 3),
      ],
    );
  }
}
