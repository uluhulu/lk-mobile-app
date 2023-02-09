import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_add_overage/invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import 'package:mkk/presentation/widgets/ui/adaptive_right_padding.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../../../../../services/platform.dart';

class InvoiceOverageSeriesList extends StatelessWidget {
  const InvoiceOverageSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceAddOverageBloc, InvoiceAddOverageState>(
      builder: (context, state) {
        if (state is InvoiceAddOveragesSeriesS) {
          return ListView.separated(
            padding: isAndroid()
                ? const EdgeInsets.only(bottom: kBasePadding * 6)
                : const EdgeInsets.only(bottom: kBasePadding * 7),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: _separator,
            itemCount: state.product.series.length,
            itemBuilder: (context, index) =>
                _itemBuilder(context, index, state),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _itemBuilder(
      BuildContext context, int index, InvoiceAddOveragesSeriesS state) {
    final bloc = context.read<InvoiceAddOverageBloc>();

    return SuperValidationEnumBuilder<OverageSeries>(
      superValidation: bloc.series,
      builder: (context, value) {
        return RadioListTile<OverageSeries>(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: state.product.series[index],
          groupValue: value,
          title: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 140),
                child: WidgetOrNullColumnHelper(
                  needColumnPadding: false,
                  needPadding: false,
                  titleRightPadding: true,
                  title: S.of(context).series,
                  value: state.product.series[index].name,
                ),
              ),
              const SizedBox(width: kBasePadding),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 140),
                child: WidgetOrNullColumnHelper(
                  needColumnPadding: false,
                  needPadding: false,
                  title: S.of(context).code,
                  value: state.product.series[index].code,
                ),
              ),
            ],
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              bloc.series.value = newValue;
            }
          },
        );
      },
    );
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
