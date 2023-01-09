import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/data/api/claims/main/entity/claims_entity.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';
import '../claims_bloc/claims_bloc.dart';
import '../filter/fields/filter_address_field.dart';
import '../filter/fields/filter_claim_status_field.dart';
import '../filter/fields/filter_period_field.dart';

class ClaimsFiltersPage extends StatefulWidget {
  final ClaimsEntity data;
  const ClaimsFiltersPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ClaimsFiltersPage> createState() => _ClaimsFiltersPageState();
}

class _ClaimsFiltersPageState extends State<ClaimsFiltersPage> {
  late ClaimsBloc bloc;

  @override
  void initState() {
    bloc = context.read<ClaimsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        if (state is ClaimsLoadingS) {
          return ScreenView(
            context: context,
            title: S.of(context).invoices,
            child: const LoadingWidget(),
          );
        }
        return ScreenView(
          floatingActionButton: BlocBuilder<ClaimsBloc, ClaimsState>(
            builder: _buttonBuilder,
          ),
          context: context,
          title: l10n.invoices,
          child: _content(context, bloc, l10n),
        );
      },
    );
  }

  Widget _content(BuildContext context, ClaimsBloc bloc, S l10n) {
    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        _invoicesClear(l10n, context, bloc),
        const SizedBox(height: kBasePadding),
        ClaimFilterPeriodField(bloc: bloc),
        const SizedBox(height: kBasePadding * 2),
        ClaimFilterAddressField(bloc: bloc),
        const SizedBox(height: kBasePadding * 2),
        ClaimStatusField(bloc: bloc),
      ],
    );
  }

  Widget _invoicesClear(S l10n, BuildContext context, ClaimsBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.filter, style: Theme.of(context).textTheme.headline2),
        TextButton.icon(
          onPressed: () {
            bloc.add(ClaimsResetFiltersE());
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

  Widget _buttonBuilder(BuildContext context, ClaimsState state) {
    return PrimaryElevatedButton(
      isLoading: state is ClaimsLoadingS ? true : false,
      canPress: state is ClaimsLoadingS ? false : true,
      btnWidth: 200,
      onPressed: () {
        Navigator.pop(context);
      },
      text: S.of(context).apply,
    );
  }
}
