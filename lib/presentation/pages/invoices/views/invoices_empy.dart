import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
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
    return Padding(
      padding: _bodyPadding(),
      child: Column(
        children: [
          InvoicesSearchSort(data: data),
          const Spacer(),
          //TODO: переписать под маленькие экраны
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 230),
            child: Lottie.asset(
              'assets/lottie/searching_animation.json',
            ),
          ),
          const SizedBox(height: kPadding),
          Text('В выбранном периоде данных нет',
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
              text: 'Изменить период'),
          const Spacer(),
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
}
