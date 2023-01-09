import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/authorization/login_bloc/login_bloc.dart';
import 'package:mkk/presentation/pages/authorization/views/login_loaded_content.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import '../../../../app/initialize/app_splash_page.dart';
import '../../../widgets/scaffold/login_screen_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSplashLoadingS) {
          return const AppSplashPage();
        }
        if (state is LoginLoadingS) {
          return const LoadingWidget();
        }
        if (state is LoginLoadedS) {
          return LoginScreenView(
            body: LoginLoadedContent(state: state),
          );
        }
        return const AppSplashPage();
      },
    );
  }
}
