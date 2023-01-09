// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/domain/enums/invoices/invoices_search_type.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/invoices_search_bloc/invoices_search_bloc.dart';
import 'package:mkk/presentation/pages/invoices/widgets/search/widgets/search_empty_info.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../widgets/buttons/primary_elevated_button.dart';

class SearchErrorWidget extends StatelessWidget {
  final String message;
  const SearchErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesSearchBloc>();
    final theme = MyTheme.of(context);
    return Container(
      margin: _padding(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kBasePadding),
          SvgPicture.asset(
            'assets/icon/danger.svg',
            width: 40,
            height: 40,
            color: theme.orangeColor,
          ),
          const SizedBox(height: kPadding),
          Text(S.of(context).search_not_found + message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: kBasePadding),
          const SearchEmptyInfo(),
          const SizedBox(height: kBasePadding * 2),
          _backButton(context),
        ],
      ),
    );
  }

  PrimaryElevatedButton _backButton(BuildContext context) {
    return PrimaryElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: S.of(context).ok,
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBasePadding * 2,
        top: kBasePadding);
  }
}
