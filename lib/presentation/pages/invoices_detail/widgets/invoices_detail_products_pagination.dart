import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_products_bloc/invoices_products_bloc.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../number_paginator/model/config.dart';
import '../../../number_paginator/ui/number_paginator.dart';

class InvoicesDetailProductsPagination extends StatelessWidget {
  const InvoicesDetailProductsPagination({
    Key? key,
    required this.bloc,
    required this.uuid,
  }) : super(key: key);

  final InvoicesProductsBloc bloc;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return BlocBuilder<InvoicesProductsBloc, InvoicesProductsState>(
      builder: (context, state) {
        return Center(
          child: NumberPaginator(
            numberPages: (state as InvoicesProductsLoadedS).numberPages,
            onPageChange: (int index) {
              bloc.add(InvoicesProductsFetchE(
                uuid: uuid,
                params: (state).params.copyWith(page: index + 1),
              ));
            },
            // initially selected index
            initialPage: state.currentPage - 1,
            rightButton: SvgPicture.asset(
              "assets/icon/arrow-right-1.svg",
              color: const Color(0xffAFAFAF),
            ),
            leftButton: SvgPicture.asset(
              "assets/icon/arrow-left-1.svg",
              color: const Color(0xffAFAFAF),
            ),
            rightButtonActive: SvgPicture.asset(
              "assets/icon/arrow-right-1.svg",
              color: MyTheme.of(context).primaryButtonColor,
            ),
            leftButtonActive: SvgPicture.asset(
              "assets/icon/arrow-left-1.svg",
              color: MyTheme.of(context).primaryButtonColor,
            ),
            config: NumberPaginatorUIConfig(
              // default height is 48
              height: 40,
              buttonShape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              buttonSelectedForegroundColor: myColors.whiteColor,
              buttonUnselectedForegroundColor: myColors.greyIconColor,
              buttonUnselectedBackgroundColor: Colors.transparent,
              buttonSelectedBackgroundColor: myColors.primaryButtonColor,
              arrowUnselectedBackgroundColor: myColors.grey1,
              arrowSelectedBackgroundColor: myColors.secondaryButtonColor,
            ),
          ),
        );
      },
    );
  }
}
