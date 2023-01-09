import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../claims_bloc/claims_bloc.dart';

class ClaimsPagination extends StatelessWidget {
  const ClaimsPagination({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ClaimsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        return NumberPaginator(
          numberPages: (state as ClaimsLoadedS).numberPages,
          onPageChange: (int index) {
            bloc.add(
                ClaimsFetchE(params: (state).params.copyWith(page: index + 1)));
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
            buttonUnselectedForegroundColor: myColors.blackColor,
            buttonUnselectedBackgroundColor: Colors.transparent,
            buttonSelectedBackgroundColor: myColors.primaryButtonColor,
            arrowUnselectedBackgroundColor: myColors.grey1,
            arrowSelectedBackgroundColor: myColors.secondaryButtonColor,
          ),
        );
      },
    );
  }
}
