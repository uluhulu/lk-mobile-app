import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/profile/info/entity/profile_info_entity.dart';
import '../../../../generated/l10n.dart';
import '../widgets/manager_info_widget.dart';
import '../widgets/office_manager_info_widget.dart';

class CompanyContactsCard extends StatelessWidget {
  final ProfileData profile;
  const CompanyContactsCard({
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
            S.of(context).contacts,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: kBasePadding),
          ManagerInfoWidget(profile: profile),
          const SizedBox(height: kBasePadding),
          OfficeManagerInfoWidget(profile: profile),
        ],
      ),
    );
  }
}
