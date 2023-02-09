import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/create_claim/widgets/create_claim_search_field.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../../widgets/fields/search_clear_text.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../create_claim_bloc/create_claim_bloc.dart';
import '../widgets/create_claim_item_list.dart';

class CreateClaimLoaded extends StatelessWidget {
  final InvoicesDetailProductsEntity entity;
  const CreateClaimLoaded({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final bloc = context.read<CreateClaimBloc>();
    return SafeArea(
      right: false,
      left: false,
      top: false,
      child: ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        floatingActionButton: navBarButton(bloc),
        child: _content(context, myColors, bloc),
      ),
    );
  }

  Widget _content(
      BuildContext context, MyThemeData myColors, CreateClaimBloc bloc) {
    final height = MediaQuery.of(context).size.height;
    if (height < 540) {
      return _lowHeightScreen(context, myColors, bloc);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          const SizedBox(height: kPadding),
          _subtitleInfo(myColors, context),
          const SizedBox(height: kPadding * 3),
          CreateClaimSearchField(
            searchValidation: bloc.search,
            suffixIcon: _clearText(bloc, myColors),
            scrollPadding: const EdgeInsets.only(bottom: 100),
          ),
          const SizedBox(height: kPadding * 3),
          const CreateClaimItemList(),
        ],
      );
    }
  }

  Widget _lowHeightScreen(
      BuildContext context, MyThemeData myColors, CreateClaimBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _title(context),
                const SizedBox(height: kPadding),
                _subtitleInfo(myColors, context),
                const SizedBox(height: kPadding * 3),
                CreateClaimSearchField(
                  searchValidation: bloc.search,
                  suffixIcon: _clearText(bloc, myColors),
                  scrollPadding: const EdgeInsets.only(bottom: 100),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kPadding * 3),
        const CreateClaimItemList(),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      S.of(context).select_product,
      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 24),
    );
  }

  Widget _subtitleInfo(MyThemeData myColors, BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icon/info-circle.svg',
          width: 24,
          height: 24,
          color: myColors.blueColor,
        ),
        const SizedBox(width: kPadding / 2),
        Flexible(
          child: Text(
            S.of(context).select_one_product,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: myColors.blueColor),
          ),
        ),
      ],
    );
  }

  Widget navBarButton(CreateClaimBloc bloc) {
    return SuperValidationBuilder(
        superValidation: bloc.invoiceItem,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: context.read<CreateClaimBloc>().invoiceItem.isValid,
            btnWidth: 200,
            onPressed: () {
              context.read<CreateClaimBloc>().add(CreateClaimProductE());
            },
            text: S.of(context).apply,
          );
        });
  }

  Widget _clearText(CreateClaimBloc bloc, MyThemeData colors) {
    return SearchClearText(
      stream: bloc.search.stream,
      initialize: () => bloc.add(CreateClaimInitializeE()),
      clear: () => bloc.search.clear(),
    );
  }
}
