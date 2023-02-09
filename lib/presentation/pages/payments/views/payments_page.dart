import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/payments/views/payments_loaded_page.dart';
import 'package:mkk/presentation/widgets/error/app_error_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../payments_bloc/payments_bloc.dart';

class PaymentsProvider extends StatelessWidget {
  const PaymentsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentsBloc>(
      create: _createPaymentsBloc,
      child: ScreenView(
          context: context,
          needPadding: false,
          needLeading: true,
          title: S.of(context).payments,
          child: const PaymentsContent()),
    );
  }

  PaymentsBloc _createPaymentsBloc(BuildContext context) {
    return PaymentsBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class PaymentsContent extends StatelessWidget {
  const PaymentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsBloc, PaymentsState>(
      builder: (context, state) {
        if (state is PaymentsLoadingS) {
          return const LoadingWidget();
        }
        if (state is PaymentsLoadedS) {
          final data = state.data.data;
          return PaymentsLoadedPage(data: data);
        }
        if (state is PaymentsErrorS) {
          //TODO: переделать под ролевую модель
          // return const AppErrorWidget(
          //   title: 'Внимание!',
          //   message: 'Извините, данный раздел Вам недоступен',
          //   hideUpdateButton: true,
          // );
          return AppErrorWidget(
            callback: () {
              context.read<PaymentsBloc>().add(PaymentsFetchE());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
