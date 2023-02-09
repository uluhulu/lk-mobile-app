import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/invoices/list/params/invoices_list_params.dart';
import '../../../../../domain/enums/invoices/invoices_sort_type.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../../invoices_bloc/invoices_bloc.dart';

class InvoicesSortContentProvider extends StatelessWidget {
  final InvoicesBloc bloc;

  const InvoicesSortContentProvider({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const InvoicesSortContent(),
    );
  }
}

class InvoicesSortContent extends StatelessWidget {
  const InvoicesSortContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final bloc = context.read<InvoicesBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            l10n.sort_by_date,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        BlocBuilder<AppMetricaBloc, AppMetricaState>(builder: (context, state) {
          return BlocBuilder<InvoicesBloc, InvoicesState>(
            builder: (context, state) {
              final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
              late InvoicesSorting sortType;
              if (state is InvoicesLoadedS) {
                sortType = state.sortType;
              } else {
                sortType = InvoicesSorting.desk;
              }
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        indent: kBasePadding,
                        endIndent: kBasePadding,
                      ),
                  itemCount: InvoicesSorting.values.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return RadioListTile<InvoicesSorting>(
                      visualDensity: VisualDensity.comfortable,
                      activeColor: MyTheme.of(context).primaryButtonColor,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: index == 0
                          ? InvoicesSorting.desk
                          : InvoicesSorting.asc,
                      groupValue: sortType,
                      onChanged: (value) {
                        if (value != null) {
                          bloc.sort.value = value;
                          bloc.add(InvoicesSortListE(type: value));
                          appMetricaBloc.add(AppmetricaOnEventE(
                              eventName:
                              "Накладные Сортировка ${index == 0 ? l10n.new_first : l10n.old_first} "));
                          Navigator.of(context).pop();
                        }
                      },
                      title: Text(
                        index == 0 ? l10n.new_first : l10n.old_first,
                      ),
                    );
                  }));
            },
          );
        }),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
        right: kBasePadding,
        top: kBasePadding * 2,
        left: kBasePadding,
        bottom: kBasePadding);
  }
}
