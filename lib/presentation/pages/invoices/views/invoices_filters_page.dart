import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/pages/invoices/widgets/filter/fields/filter_delivery_address_field.dart';
import 'package:mkk/presentation/pages/invoices/widgets/filter/fields/filter_marking_item_field.dart';
import 'package:mkk/presentation/pages/invoices/widgets/filter/fields/filter_marking_status_field.dart';
import 'package:mkk/presentation/pages/invoices/widgets/filter/fields/filter_period_field.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../generated/l10n.dart';
import '../invoices_bloc/invoices_bloc.dart';

class InvoicesFiltersPage extends StatefulWidget {
  final InvoicesEntity data;
  final bool? openCalendar;
  const InvoicesFiltersPage({
    Key? key,
    required this.data,
    this.openCalendar = false,
  }) : super(key: key);

  @override
  State<InvoicesFiltersPage> createState() => _InvoicesFiltersPageState();
}

class _InvoicesFiltersPageState extends State<InvoicesFiltersPage> {
  late InvoicesBloc bloc;

  @override
  void initState() {
    bloc = context.read<InvoicesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<InvoicesBloc, InvoicesState>(
      builder: (context, state) {
        if (state is InvoicesLoadingS) {
          return ScreenView(
            context: context,
            title: S.of(context).invoices,
            child: const LoadingWidget(),
          );
        }
        return ScreenView(
          floatingActionButton: BlocBuilder<InvoicesBloc, InvoicesState>(
            builder: _buttonBuilder,
          ),
          context: context,
          title: l10n.invoices,
          child: _content(context, bloc, l10n),
        );
      },
    );
  }

  Widget _content(BuildContext context, InvoicesBloc bloc, S l10n) {
    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        _invoicesClear(l10n, context, bloc),
        const SizedBox(height: kBasePadding),
        FilterPeriodField(bloc: bloc),
        const SizedBox(height: kBasePadding * 2),
        FilterAddressField(bloc: bloc, data: widget.data),
        const SizedBox(height: kBasePadding * 2),
        FilterMarkingItem(bloc: bloc),
        const SizedBox(height: kBasePadding * 2),
        FilterMarkingStatus(bloc: bloc, data: widget.data),
        const SizedBox(height: kBasePadding * 5),
      ],
    );
  }

  Widget _invoicesClear(S l10n, BuildContext context, InvoicesBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.filter, style: Theme.of(context).textTheme.headline2),
        TextButton.icon(
          onPressed: () {
            bloc.add(InvoicesResetFiltersE());
            //Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icon/refresh.svg',
            color: MyTheme.of(context).errorColor,
          ),
          label: Text(
            S.of(context).reset,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        )
      ],
    );
  }

  Widget _buttonBuilder(BuildContext context, InvoicesState state) {
    return PrimaryElevatedButton(
      isLoading: state is InvoicesLoadingS ? true : false,
      canPress: state is InvoicesLoadingS ? false : true,
      btnWidth: 200,
      onPressed: () {
        Navigator.pop(context);
      },
      text: S.of(context).apply,
    );
  }
}
