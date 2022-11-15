// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/restore_password/views/restore_password_loaded_page.dart';
import 'package:mkk/presentation/widgets/loading_page.dart';
import 'package:mkk/services/error/bloc/error_bloc.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../restore_password_bloc/restore_password_bloc.dart';
import '../widgets/restore_password_error_content.dart';

class RestorePasswordProvider extends StatelessWidget {
  const RestorePasswordProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestorePasswordBloc>(
      create: _createBloc,
      child: const RestorePasswordContent(),
    );
  }

  RestorePasswordBloc _createBloc(BuildContext context) {
    return RestorePasswordBloc(
      repository: sl.get<Repository>(),
      errorBloc: context.read<ErrorBloc>(),
    );
  }
}

class RestorePasswordContent extends StatefulWidget {
  const RestorePasswordContent({super.key});

  @override
  State<RestorePasswordContent> createState() => _RestorePasswordContentState();
}

class _RestorePasswordContentState extends State<RestorePasswordContent> {
  late final TextEditingController _loginController;
  var companyId = 2;

  @override
  void initState() {
    _loginController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RestorePasswordBloc bloc = context.read<RestorePasswordBloc>();
    return ScreenView(
      context: context,
      title: S.of(context).restore_password,
      child: BlocConsumer<RestorePasswordBloc, RestorePasswordState>(
        builder: (context, state) {
          if (state is RestorePasswordLoadingS) {
            return const LoadingPage();
          }
          if (state is RestorePasswordLoadedS) {
            companyId = state.company.id;
            return RestorePasswordLoadedPage(
              loginController: _loginController,
              bloc: bloc,
              state: state,
              companyId: companyId,
            );
          }
          //TODO: доделать логику
          if (state is RestorePasswordEnterCodeS) {
            return const Center(
              child: Text(
                'Письмо было выслано на почту, дальнешая логика не реализована в соответствии с требованиями',
                textAlign: TextAlign.center,
              ),
            );
          }
          return const SizedBox.shrink();
        },
        listener: _listener,
      ),
    );
  }

  void _listener(BuildContext context, RestorePasswordState state) async {
    if (state is RestorePasswordErrorS) {
      await Future.delayed(const Duration(milliseconds: 400), () {
        showModalBottomSheet<void>(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSheetBorderRadius),
              topRight: Radius.circular(kSheetBorderRadius),
            )),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            context: context,
            builder: (BuildContext context) {
              return const RestorePasswordErrorContent();
            });
      });
    }
  }
}
