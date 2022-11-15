// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/payments/views/payments_loaded_page.dart';
import '../../../widgets/loading_page.dart';
import '../payments_bloc/payments_bloc.dart';

class PaymentsProvider extends StatelessWidget {
  const PaymentsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentsBloc>(
      create: _createPaymentsBloc,
      child: const PaymentsContent(),
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
          return const LoadingPage();
        } else if (state is PaymentsLoadedS) {
          final data = state.data.data;
          return PaymentsLoadedPage(data: data);
        }
        return Container();
      },
    );
  }
}
