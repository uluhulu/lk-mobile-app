import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/restore_password/views/restore_password_enter_code.dart';
import 'package:mkk/presentation/pages/restore_password/views/restore_password_enter_new_password.dart';
import 'package:mkk/presentation/pages/restore_password/views/restore_password_loaded_page.dart';
import 'package:mkk/presentation/pages/restore_password/widgets/modals/success_modal_content.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/services/error/bloc/error_bloc.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../restore_password_bloc/restore_password_bloc.dart';
import '../widgets/modals/password_error_modal_content.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScreenView(
      context: context,
      title: S.of(context).restore_password,
      child: BlocConsumer<RestorePasswordBloc, RestorePasswordState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, RestorePasswordState state) {
    final RestorePasswordBloc bloc = context.read<RestorePasswordBloc>();
    if (state is RestorePasswordLoadingS) {
      return const LoadingWidget();
    }
    if (state is RestorePasswordLoadedS) {
      return RestorePasswordLoadedPage(
        bloc: bloc,
        state: state,
      );
    }
    if (state is RestorePasswordEnterCodeS) {
      return RestorePasswordEnterCode(
        message: state.message,
      );
    }
    if (state is RestorePasswordEnterNewPasswordS) {
      return const RestorePasswordEnterNewPassword();
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, RestorePasswordState state) async {
    if (state is RestorePasswordErrorS) {
      BaseBottomSheetWidget(
        context: context,
        child: const PasswordErrorModalContent(),
      ).show();
    }
    if (state is ResetPasswordSuccessS) {
      await BaseBottomSheetWidget(
        context: context,
        isDismissible: false,
        child: SuccessModalContent(message: state.message),
      ).show();
    }
  }
}
