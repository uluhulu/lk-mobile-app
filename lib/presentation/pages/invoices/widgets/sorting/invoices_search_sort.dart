import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/help/navigation_invoices_filter_page_params.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/widgets/sorting/invoices_sort_content.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../../data/api/invoices/list/params/invoices_list_params.dart';
import '../../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../../invoices_bloc/invoices_bloc.dart';
import '../invoices_search_field.dart';

class InvoicesSearchSort extends StatelessWidget {
  const InvoicesSearchSort({
    Key? key,
    required this.data,
  }) : super(key: key);

  final InvoicesEntity data;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesBloc>();
    final myColors = MyTheme.of(context);
    final l10n = S.of(context);
    return Column(
      children: [
        const InvoicesSearchField(),
        const SizedBox(height: kBasePadding),
        _sortButton(context, bloc, myColors, l10n),
      ],
    );
  }

  Widget _sortButton(
    BuildContext context,
    InvoicesBloc bloc,
    MyThemeData myColors,
    S l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            BaseBottomSheetWidget(
                context: context,
                child: InvoicesSortContentProvider(
                  bloc: bloc,
                )).show();
          },
          child: _sortButtonText(l10n),
        ),
        _filterButton(context, bloc, myColors, l10n)
      ],
    );
  }

  Widget _sortButtonText(S l10n) {
    return Row(
      children: [
        BlocBuilder<InvoicesBloc, InvoicesState>(
          builder: (context, state) {
            late InvoicesSorting sortType;
            if (state is InvoicesLoadedS) {
              sortType = state.sortType;
            } else {
              sortType = InvoicesSorting.desk;
            }
            return Text(
                sortType == InvoicesSorting.desk
                    ? l10n.new_first
                    : l10n.old_first,
                style: Theme.of(context).textTheme.headline3);
          },
        ),
        const SizedBox(width: kPadding),
        SvgPicture.asset(
          'assets/icon/arrow.svg',
          width: 24,
          height: 24,
        ),
      ],
    );
  }

  Widget _filterButton(
    BuildContext context,
    InvoicesBloc bloc,
    MyThemeData myColors,
    S l10n,
  ) {
    return Row(
      children: [
        BlocBuilder<AppMetricaBloc, AppMetricaState>(
          builder: (context, state) {
            final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
            return TextButton.icon(
              onPressed: () => _filterOnPressed(context, bloc, appMetricaBloc),
              icon: SvgPicture.asset(
                'assets/icon/filter.svg',
                width: 24,
                height: 24,
                color: myColors.primaryButtonColor,
              ),
              label: Text(l10n.filter,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: myColors.primaryButtonColor)),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
          decoration: BoxDecoration(
            color: myColors.lightBlueColor,
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
          ),
          child: bloc.getFilterCount() != null
              ? Text(bloc.getFilterCount().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: myColors.whiteColor))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _filterOnPressed(BuildContext context, InvoicesBloc bloc, AppMetricaBloc appMetricaBloc,) {
    Navigator.of(context).pushNamed(
      AppRoutes.invoicesFilters,
      arguments: InvoicesFilterPageParams(data: data, bloc: bloc),
    );
    appMetricaBloc.add(AppmetricaOnEventE(
        eventName:
        "Накладные ${S.of(context).button_on_pressed} ${S.of(context).filter} "));
  }
}
