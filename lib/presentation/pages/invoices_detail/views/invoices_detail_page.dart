import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/create_claim/create_claim_bloc/create_claim_bloc.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_detail_bloc/invoices_detail_bloc.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/error/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../invoices_products_bloc/invoices_products_bloc.dart';
import 'invoices_detail_loaded.dart';

class InvoicesDetailProvider extends StatelessWidget {
  final String uuid;
  final bool fromSearch;
  const InvoicesDetailProvider({
    Key? key,
    required this.uuid,
    this.fromSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InvoicesDetailBloc>(
          create: _createDetailBloc,
        ),
        BlocProvider<InvoicesProductsBloc>(
          create: _createProductsBloc,
        ),
        BlocProvider<CreateClaimBloc>(
          create: _createClaimBloc,
        ),
      ],
      child: ScreenView(
        needPadding: false,
        context: context,
        title: 'Накладная',
        child: const InvoicesDetailContent(),
      ),
    );
  }

  InvoicesDetailBloc _createDetailBloc(BuildContext context) {
    final bloc = InvoicesDetailBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
    if (!fromSearch) {
      bloc.add(InvoicesDetailFetchE(uuid: uuid));
    }
    return bloc;
  }

  InvoicesProductsBloc _createProductsBloc(BuildContext context) {
    return InvoicesProductsBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }

  CreateClaimBloc _createClaimBloc(BuildContext context) {
    return CreateClaimBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }
}

class InvoicesDetailContent extends StatelessWidget {
  const InvoicesDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicesDetailBloc, InvoicesDetailState>(
      builder: (context, state) {
        if (state is InvoicesDetailLoadingS) {
          return const LoadingWidget();
        }
        if (state is InvoicesDetailLoadedS) {
          return InvoicesDetailLoaded(
            detailData: state.detail,
          );
        }
        if (state is InvoicesDetailErrorS) {
          return _error(context);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _error(BuildContext context) {
    return AppErrorWidget(callback: () {
      context.read<InvoicesDetailBloc>().add(
            InvoicesDetailRefreshE(),
          );
    });
  }
}