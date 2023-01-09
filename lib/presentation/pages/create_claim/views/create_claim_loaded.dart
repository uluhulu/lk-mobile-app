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
    return ScreenView(
      context: context,
      title: S.of(context).claim_drafts,
      floatingActionButton: navBarButton(bloc),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите товар из накладной',
            style:
                Theme.of(context).textTheme.headline2?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: kPadding),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icon/info-circle.svg',
                width: 24,
                height: 24,
                color: myColors.blueColor,
              ),
              const SizedBox(width: kPadding / 2),
              Text(
                'За один раз можно добавить 1 товар ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: myColors.blueColor),
              ),
            ],
          ),
          const SizedBox(height: kPadding * 3),
          CreateClaimSearchField(
            searchValidation: bloc.search,
          ),
          const SizedBox(height: kPadding * 3),
          const CreateClaimItemList(),
        ],
      ),
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
}
