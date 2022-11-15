import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/authorization/login_bloc/login_bloc.dart';
import 'package:mkk/presentation/pages/authorization/view/login_loaded_content.dart';
import 'package:mkk/presentation/widgets/loading_page.dart';
import '../../../widgets/scaffold/login_screen_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserRepository userRepository = sl.get<UserRepository>();

  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final String? userLogin;
  late final int? regionalCompany;
  var companyId = 2;

  @override
  void initState() {
    userLogin = userRepository.getUserLogin();
    regionalCompany = userRepository.getRegionalCompany();
    if (userLogin != null && regionalCompany != null) {
      _loginController = TextEditingController(text: userLogin);
      _passwordController = TextEditingController();
      companyId = regionalCompany!;
    } else {
      _loginController = TextEditingController();
      _passwordController = TextEditingController();
      companyId = 2;
    }
    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenView(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadingS) {
            return const LoadingPage();
          }
          if (state is LoginLoadedS) {
            companyId = state.company.id;
            return LoginLoadedContent(
              companyId: companyId,
              loginController: _loginController,
              passwordController: _passwordController,
              state: state,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
