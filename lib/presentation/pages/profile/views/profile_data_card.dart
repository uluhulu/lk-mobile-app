import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/launch_url_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/profile/info/entity/profile_info_entity.dart';
import '../../../widgets/buttons/secondary_elevated_button.dart';
import '../widgets/title_info_widget.dart';

class ProfileDataCard extends StatelessWidget {
  final ProfileData profile;
  const ProfileDataCard({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBasePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).my_data,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: kBasePadding),
          TitleInfoWidget(
            title: S.of(context).full_name,
            subtitle: profile.client.superShortName,
          ),
          TitleInfoWidget(
            title: S.of(context).inn,
            subtitle: profile.client.inn,
          ),
          TitleInfoWidget(
            title: S.of(context).email,
            subtitle: profile.client.email,
            onTap: () => LaunchUrlHelper.launchEmail(profile.client.email),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: MyTheme.of(context).primaryButtonColor,
                ),
          ),
          const SizedBox(height: kBasePadding),
          SecondaryElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.act);
            },
            text: S.of(context).request_act,
            icon: SvgPicture.asset(
              'assets/icon/stickynote.svg',
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: kBasePadding * 2),
        ],
      ),
    );
  }
}
