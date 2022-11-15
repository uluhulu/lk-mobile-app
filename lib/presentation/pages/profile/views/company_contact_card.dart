import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/launch_url_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/profile/info/entity/profile_info_entity.dart';
import '../widgets/icon_info_widget.dart';
import '../widgets/title_info_widget.dart';

class CompanyContactsCard extends StatelessWidget {
  final ProfileData profile;
  const CompanyContactsCard({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBasePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Контакты ООО «ФК ПУЛЬС»',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: kBasePadding),
          TitleInfoWidget(
            title: 'Менеджер',
            subtitle: profile.client.manager?.name ?? '',
          ),
          IconInfoWidget(
            content: profile.client.manager?.phone ?? '',
            subtitle: 'я пока не понял что тут должно быть)',
            asset: SvgPicture.asset(
              'assets/icon/call.svg',
              color: myColors.phoneIconColor,
            ),
            onPressed: () =>
                LaunchUrlHelper().phoneUrl(profile.client.manager?.phone ?? ''),
          ),
          IconInfoWidget(
              content: profile.client.manager?.email ?? '',
              asset: SvgPicture.asset(
                'assets/icon/sms.svg',
                color: myColors.emailIconColor,
              ),
              onPressed: () => LaunchUrlHelper.launchEmail(
                  profile.client.manager?.email ?? '')),
          const SizedBox(height: kPadding),
          Text('Офис-менеджер', style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: kBasePadding),
          IconInfoWidget(
            content: profile.client.officeManager?.phone ?? '',
            asset: SvgPicture.asset(
              'assets/icon/call.svg',
              color: myColors.phoneIconColor,
            ),
            onPressed: () => LaunchUrlHelper()
                .phoneUrl(profile.client.officeManager?.phone ?? ''),
          ),
          const SizedBox(height: kPadding),
          IconInfoWidget(
              content: profile.client.officeManager?.email ?? 'Не указан',
              asset: SvgPicture.asset(
                'assets/icon/sms.svg',
                color: myColors.emailIconColor,
              ),
              onPressed: () => LaunchUrlHelper.launchEmail(
                  profile.client.officeManager?.email ?? '')),
        ],
      ),
    );
  }
}
