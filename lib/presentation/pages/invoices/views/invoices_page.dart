import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';
import 'package:mkk/presentation/pages/invoices/views/invoices_empy.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../data/api/invoices/list/params/invoices_list_params.dart';
import '../../../widgets/scaffold/screen_view.dart';
import 'invoices_loaded.dart';

class InvoicesProvider extends StatelessWidget {
  const InvoicesProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoicesBloc>(
      create: _createBloc,
      child: ScreenView(
        context: context,
        needPadding: false,
        needLeading: true,
        title: S.of(context).invoices,
        child: const InvoicesContent(),
      ),
    );
  }

  InvoicesBloc _createBloc(BuildContext context) {
    return InvoicesBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class InvoicesContent extends StatelessWidget {
  const InvoicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<InvoicesBloc>();
    return BlocBuilder<InvoicesBloc, InvoicesState>(
      builder: (context, state) {
        if (state is InvoicesLoadingS) {
          return const LoadingWidget();
        }
        if (state is InvoicesLoadedS) {
          return InvoicesLoaded(
            data: state.data,
            numberPages: state.numberPages,
            onPageChange: (index) => bloc.add(
              InvoicesFetchE(
                params: InvoicesListParams(
                  page: index,
                  dateFrom: DateFormats.yyyyMMdd(DateTime.now()
                      .subtract(Duration(days: DateTime.now().weekday - 1))),
                  dateTo: DateFormats.yyyyMMdd(DateTime.now()),
                ),
              ),
            ),
          );
        }
        if (state is InvoicesEmptyS) {
          return InvoicesEmpty(data: state.data);
        }
        if (state is InvoicesErrorS) {
          return AppErrorWidget(callback: () {
            bloc.add(InvoicesRefreshE());
          });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
