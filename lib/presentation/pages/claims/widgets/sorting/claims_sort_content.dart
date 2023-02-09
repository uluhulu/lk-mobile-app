import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claims/main/params/claims_params.dart';
import '../../../../../domain/enums/invoices/invoices_sort_type.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/appmetrica/bloc/appmetrica_bloc.dart';

class ClaimsSortContentProvider extends StatelessWidget {
  final ClaimsBloc bloc;
  const ClaimsSortContentProvider({
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
    final bloc = context.read<ClaimsBloc>();
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: kBasePadding,
              top: kBasePadding * 2,
              left: kBasePadding,
              bottom: kBasePadding),
          child: Text(l10n.sort_by_date,
              style: Theme.of(context).textTheme.headline2),
        ),
        BlocBuilder<ClaimsBloc, ClaimsState>(
          builder: (context, state) {
            late ClaimsSorting sortType;
            if (state is ClaimsLoadedS) {
              sortType = state.sortType;
            } else {
              sortType = ClaimsSorting.desk;
            }
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      indent: kBasePadding,
                      endIndent: kBasePadding,
                    ),
                itemCount: ClaimsSorting.values.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return  BlocBuilder<AppMetricaBloc, AppMetricaState>(
                    builder: (context, state){
                      final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
                      return RadioListTile<ClaimsSorting>(
                        visualDensity: VisualDensity.comfortable,
                        activeColor: MyTheme.of(context).primaryButtonColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: index == 0 ? ClaimsSorting.desk : ClaimsSorting.asc,
                        groupValue: sortType,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.sort.value = value;
                            context
                                .read<ClaimsBloc>()
                                .add(ClaimsSortListE(type: value));
                            Navigator.of(context).pop();
                            appMetricaBloc.add(AppmetricaOnEventE(
                                eventName:
                                  "Претензии Сортировка ${index == 0 ? l10n.new_first : l10n.old_first} "));
                          }
                        },
                        title: Text(
                          index == 0 ? l10n.new_first : l10n.old_first,
                        ),
                      );
                    }

                  );
                }));
          },
        ),
      ],
    );
  }
}
