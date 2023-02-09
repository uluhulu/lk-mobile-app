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

class ManagerInfoWidget extends StatelessWidget {
  const ManagerInfoWidget({
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
          title: S.of(context).manager,
          subtitle: profile.client.manager?.name,
        ),
        NullCheckWidget(
          value: profile.client.manager?.phoneOrg,
          child: _phoneOrg(myColors),
        ),
        NullCheckWidget(
          value: profile.client.manager?.email,
          child: _email(myColors),
        ),
      ],
    );
  }

  Widget _email(MyThemeData myColors) {
    return IconInfoWidget(
      bottomPadding: kPadding,
      content: profile.client.manager?.email,
      asset: SvgPicture.asset(
        'assets/icon/sms.svg',
        color: myColors.emailIconColor,
      ),
      onPressed: () =>
          LaunchUrlHelper.launchEmail(profile.client.manager?.email ?? ''),
    );
  }

  Widget _phoneOrg(MyThemeData myColors) {
    return IconInfoWidget(
      bottomPadding: kBasePadding,
      content: profile.client.manager?.phoneOrg,
      subtitle: profile.client.manager?.phoneShort,
      subtitleText: 'доб.:',
      asset: SvgPicture.asset(
        'assets/icon/call.svg',
        color: myColors.phoneIconColor,
      ),
      onPressed: () =>
          LaunchUrlHelper().phoneUrl(profile.client.manager?.phoneOrg ?? ''),
    );
  }
}
