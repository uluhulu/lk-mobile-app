import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/views/claim_drafts_list_empty.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import '../../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import 'claim_drafts_list_loaded.dart';

class ClaimDraftsListProvider extends StatelessWidget {
  const ClaimDraftsListProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimDraftsListBloc>(
      create: _createBloc,
      child: ScreenView(
        needPadding: false,
        context: context,
        title: S.of(context).claim_drafts,
        child: const ClaimDraftsListContent(),
      ),
    );
  }

  ClaimDraftsListBloc _createBloc(BuildContext context) {
    return ClaimDraftsListBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class ClaimDraftsListContent extends StatelessWidget {
  const ClaimDraftsListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimDraftsListBloc, ClaimDraftsListState>(
      builder: (context, state) {
        if (state is ClaimDraftsListLoadingS) {
          return const LoadingWidget();
        }
        if (state is ClaimDraftsListLoadedS) {
          return ClaimDraftsListLoaded(
            entity: state.entity,
          );
        }
        if (state is ClaimDraftsListEmptyS) {
          return const ClaimsDraftsListEmpty();
        }
        if (state is ClaimDraftsListErrorS) {
          return Padding(
            padding: const EdgeInsets.all(kBasePadding),
            child: AppErrorWidget(
              callback: () {
                context.read<ClaimDraftsListBloc>().add(
                    ClaimDraftsListFetchE(params: ClaimDraftsListParams()));
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
