import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/core/help/navigation_claims_filter_page_params.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import 'invoices_detail_button.dart';

class InvoicesRowButton extends StatelessWidget {
  final String uuid;

  const InvoicesRowButton({
    super.key,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return BlocBuilder<AppMetricaBloc, AppMetricaState>(
        builder: (context, state) {
      final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
      return Container(
        padding: const EdgeInsets.all(kBasePadding),
        color: myColors.greyContainerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailButton(
              iconPath: 'assets/icon/pretension.svg',
              title: S.of(context).issue_claim,
              iconColor: myColors.errorColor,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.createClaimDraft,
                  arguments: CreateClaimDraftParams(uuid: uuid),
                );
                appMetricaBloc.add(
                  AppmetricaOnEventE(
                    eventName:
                        "Претензия ${S.of(context).button_on_pressed} ${S.of(context).issue_claim}",
                  ),
                );
              },
            ),
            DetailButton(
              iconPath: 'assets/icon/box-add.svg',
              title: S.of(context).add_excess,
              iconColor: myColors.yellowColor,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.invoiceAddOverages,
                  arguments: CreateClaimDraftParams(uuid: uuid),
                );
                appMetricaBloc.add(
                  AppmetricaOnEventE(
                    eventName:
                        "Претензия ${S.of(context).button_on_pressed} ${S.of(context).add_excess}",
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
