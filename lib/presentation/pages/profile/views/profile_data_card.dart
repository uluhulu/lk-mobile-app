import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/app_routes.dart';
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
            'Мои данные',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: kBasePadding),
          TitleInfoWidget(
            title: 'Полное наименование',
            subtitle: profile.client.superShortName,
          ),
          TitleInfoWidget(
            title: 'ИНН',
            subtitle: profile.client.inn,
          ),
          TitleInfoWidget(
            title: 'E-mail',
            subtitle: profile.client.email,
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
