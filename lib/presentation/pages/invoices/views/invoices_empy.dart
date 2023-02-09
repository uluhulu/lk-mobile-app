import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/navigation_invoices_filter_page_params.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../invoices_bloc/invoices_bloc.dart';
import '../widgets/sorting/invoices_search_sort.dart';

class InvoicesEmpty extends StatelessWidget {
  final InvoicesEntity data;
  const InvoicesEmpty({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesBloc>();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: _bodyPadding(),
      child: ListView(
        children: [
          InvoicesSearchSort(data: data),
          Column(
            children: [
              _topPadding(height),
              ConstrainedBox(
                constraints: width < 322
                    ? const BoxConstraints(maxHeight: 150)
                    : const BoxConstraints(maxHeight: 210),
                child: Lottie.asset(
                  'assets/lottie/searching_animation.json',
                ),
              ),
              const SizedBox(height: kPadding),
              Text(S.of(context).no_data,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: MyTheme.of(context).greyIconColor)),
              const SizedBox(height: kPadding * 3),
              PrimaryElevatedButton(
                btnWidth: 250,
                onPressed: () {
                  _filterOnPressed(context, bloc);
                },
                text: S.of(context).change_period,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _filterOnPressed(BuildContext context, InvoicesBloc bloc) {
    Navigator.of(context).pushNamed(
      AppRoutes.invoicesFilters,
      arguments: InvoicesFilterPageParams(data: data, bloc: bloc),
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kPadding,
    );
  }

  Widget _topPadding(double height) {
    if (height < 600) {
      return const SizedBox(height: kBasePadding);
    } else if (height > 600 && height < 700) {
      return const SizedBox(height: kBasePadding * 2);
    } else if (height > 700 && height < 800) {
      return const SizedBox(height: kBasePadding * 4);
    } else if (height > 800) {
      return const SizedBox(height: kBasePadding * 5);
    } else {
      return const SizedBox(height: kBasePadding);
    }
  }
}
