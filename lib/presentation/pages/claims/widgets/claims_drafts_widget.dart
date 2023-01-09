import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claims/main/entity/claims_entity.dart';

class ClaimsDraftsWidget extends StatelessWidget {
  const ClaimsDraftsWidget({
    Key? key,
    required this.claims,
  }) : super(key: key);

  final ClaimDraftsListEntity? claims;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.claimDraftsList);
      },
      child: Container(
        decoration: BoxDecoration(
          color: myColors.secondaryButtonColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(kBodyRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kBasePadding),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icon/document-text.svg',
                color: myColors.primaryButtonColor,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: kBasePadding),
              Text(
                S.of(context).claim_drafts,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(width: kPadding),
              Container(
                // width: 24,
                // height: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: myColors.lightBlueColor,
                  borderRadius: BorderRadius.circular(kBorderRadius / 2),
                ),
                child: Center(
                  child: Text(
                    claims?.meta.total.toString() ?? '0',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: myColors.whiteColor,
                        ),
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icon/arrow-right.svg',
                color: myColors.greyIconColor,
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
