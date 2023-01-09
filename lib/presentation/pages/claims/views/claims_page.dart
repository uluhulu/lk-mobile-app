import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/data/api/claims/main/params/claims_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';
import 'package:mkk/presentation/pages/claims/views/claims_empty.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import '../../../../core/utils/date_format.dart';
import '../../../widgets/scaffold/screen_view.dart';
import 'claims_loaded.dart';

class ClaimsProvider extends StatelessWidget {
  const ClaimsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimsBloc>(
      create: _createClaimsBloc,
      child: ScreenView(
        context: context,
        title: S.of(context).claims,
        needPadding: false,
        needLeading: true,
        child: const ClaimsContent(),
      ),
    );
  }

  ClaimsBloc _createClaimsBloc(BuildContext context) {
    return ClaimsBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class ClaimsContent extends StatelessWidget {
  const ClaimsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final claimsBloc = context.read<ClaimsBloc>();
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        if (state is ClaimsLoadingS) {
          return const LoadingWidget();
        }
        if (state is ClaimsLoadedS) {
          return ClaimsLoaded(
            claims: state.data,
            claimDrafts: state.drafts,
            numberPages: state.numberPages,
            onPageChange: (index) => claimsBloc.add(
              ClaimsFetchE(
                params: ClaimsParams(
                  page: index,
                  dateFrom: DateFormats.yyyyMMdd(DateTime.now()
                      .subtract(Duration(days: DateTime.now().weekday - 1))),
                  dateTo: DateFormats.yyyyMMdd(DateTime.now()),
                ),
              ),
            ),
          );
        }
        if (state is ClaimsEmptyS) {
          return ClaimsEmpty(
            data: state.data,
            claimDrafts: state.drafts,
          );
        }
        if (state is ClaimsErrorS) {
          return AppErrorWidget(
            callback: () {
              claimsBloc.add(ClaimsRefreshE());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
