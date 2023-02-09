import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/claims/claim_drafts_counter_bloc/claim_drafts_counter_bloc.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';

class ClaimDraftsCountProvider extends StatelessWidget {
  const ClaimDraftsCountProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimDraftsCounterBloc>(
      create: _createBloc,
      child: const ClaimsDraftsWidget(),
    );
  }

  ClaimDraftsCounterBloc _createBloc(BuildContext context) {
    return ClaimDraftsCounterBloc(
      repository: sl.get<Repository>(),
      appBlocObserver: context.read<ClaimDraftsObserverBloc>(),
    );
  }
}

class ClaimsDraftsWidget extends StatelessWidget {
  const ClaimsDraftsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return BlocBuilder<AppMetricaBloc, AppMetricaState>(
        builder: (context, state) {
      final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.claimDraftsList);
          appMetricaBloc.add(AppmetricaOnEventE(
              eventName:
                  "Претензии ${S.of(context).button_on_pressed} ${S.of(context).claim_drafts}"));
        },
        child: Container(
          decoration: BoxDecoration(
            color: myColors.secondaryButtonColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(kBodyRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kBasePadding),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icon/document-text.svg',
                  color: myColors.primaryButtonColor,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: kBasePadding),
                Text(
                  S.of(context).claim_drafts,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(width: kPadding),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: myColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(kBorderRadius / 2),
                  ),
                  child: _counter(myColors),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icon/arrow-right.svg',
                  color: myColors.greyIconColor,
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _counter(MyThemeData myColors) {
    return Center(
      child: BlocBuilder<ClaimDraftsCounterBloc, ClaimDraftsCounterState>(
        builder: (context, state) {
          if (state is ClaimDraftsCounterLoadedS) {
            return Text(
              state.count.toString(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: myColors.whiteColor,
                  ),
            );
          }
          return Text(
            '0',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: myColors.whiteColor,
                ),
          );
        },
      ),
    );
  }
}
