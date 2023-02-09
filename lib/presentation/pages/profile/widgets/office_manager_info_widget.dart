import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/profile/widgets/title_info_widget.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/launch_url_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/profile/info/entity/profile_info_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/ui/helpers/null_check_widget.dart';
import 'icon_info_widget.dart';

class OfficeManagerInfoWidget extends StatelessWidget {
  const OfficeManagerInfoWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleInfoWidget(
          title: S.of(context).office_manager,
          subtitle: profile.client.officeManager?.name,
        ),
        NullCheckWidget(
          value: profile.client.officeManager?.phoneOrg,
          child: IconInfoWidget(
            bottomPadding: kBasePadding,
            content: profile.client.officeManager?.phoneOrg,
            subtitle: profile.client.officeManager?.phoneShort,
            subtitleText: 'доб.:',
            asset: SvgPicture.asset(
              'assets/icon/call.svg',
              color: myColors.phoneIconColor,
            ),
            onPressed: () => LaunchUrlHelper()
                .phoneUrl(profile.client.officeManager?.phoneOrg ?? ''),
          ),
        ),
        NullCheckWidget(
          value: profile.client.officeManager?.phone,
          child: IconInfoWidget(
            bottomPadding: kBasePadding,
            content: profile.client.officeManager?.phone,
            subtitle: profile.client.officeManager?.phoneShort,
            subtitleText: 'доб.:',
            asset: SvgPicture.asset(
              'assets/icon/call.svg',
              color: myColors.phoneIconColor,
            ),
            onPressed: () => LaunchUrlHelper()
                .phoneUrl(profile.client.officeManager?.phone ?? ''),
          ),
        ),
        NullCheckWidget(
          value: profile.client.officeManager?.mail,
          child: IconInfoWidget(
            content: profile.client.officeManager?.mail,
            asset: SvgPicture.asset(
              'assets/icon/sms.svg',
              color: myColors.emailIconColor,
            ),
            onPressed: () => LaunchUrlHelper.launchEmail(
                profile.client.officeManager?.mail ?? ''),
          ),
        ),
      ],
    );
  }
}
