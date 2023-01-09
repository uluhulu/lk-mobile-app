import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claims_detail/claim_detail_bloc/claim_detail_bloc.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/error/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../claim_products_bloc/claim_products_bloc.dart';
import 'claim_detail_loaded.dart';

class ClaimDetailProvider extends StatelessWidget {
  final String uuid;
  final bool fromSearch;
  const ClaimDetailProvider({
    super.key,
    required this.uuid,
    this.fromSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClaimDetailBloc>(
          create: _createDetailBloc,
        ),
        BlocProvider<ClaimProductsBloc>(
          create: _createProductsBloc,
        ),
      ],
      child: ScreenView(
        context: context,
        needPadding: false,
        title: S.of(context).claim,
        child: const ClaimDetailContent(),
      ),
    );
  }

  ClaimDetailBloc _createDetailBloc(BuildContext context) {
    final bloc = ClaimDetailBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
    if (!fromSearch) {
      bloc.add(ClaimDetailFetchE());
    }
    return bloc;
  }

  ClaimProductsBloc _createProductsBloc(BuildContext context) {
    return ClaimProductsBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }
}

class ClaimDetailContent extends StatelessWidget {
  const ClaimDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimDetailBloc, ClaimDetailState>(
      builder: (context, state) {
        if (state is ClaimDetailLoadingS) {
          return const LoadingWidget();
        } else if (state is ClaimDetailLoadedS) {
          return ClaimDetailLoaded(
            detailData: state.claimDetail,
          );
        } else if (state is ClaimDetailErrorS) {
          return AppErrorWidget(
            callback: () {
              context.read<ClaimDetailBloc>().add(ClaimDetailFetchE());
            },
          );
        }
        return Container();
      },
    );
  }
}
