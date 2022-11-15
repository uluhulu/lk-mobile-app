import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/set_pin_code.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/set_pin_code_re_enter.dart';
import '../../widgets/scaffold/login_screen_view.dart';
import 'local_auth_bloc/local_auth_bloc.dart';

class SetPinCodeBuilder extends StatelessWidget {
  const SetPinCodeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreenView(
      body: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, LocalAuthState state) {
    if (state is LocalAuthEnteredS) {
      return SetPinCodeReEnter(actualPin: state.pin);
    }

    return const SetPinCode(isSetPin: false);
  }

  void _listener(BuildContext context, LocalAuthState state) {
    if (state is LocalAuthSuccessS) {
      context.read<BannerBloc>().add(BannerSetPinShowedE());
    }
  }
}
