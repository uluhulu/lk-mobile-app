import 'package:mkk/presentation/pages/authorization/views/login_page.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import '../../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authorization_bloc/authorization_bloc.dart';
import '../loca_auth/local_auth_page.dart';
import 'authorized_provider.dart';

class AuthorizationBuilderWidget extends StatelessWidget {
  final Widget child;
  const AuthorizationBuilderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      // listener: (context, state) {
      //   if (state is AuthorizationNeedLoginS) {
      //     context.read<BannerBloc>().add(BannerInitializeE());
      //   }
      // },
      builder: (context, state) {
        if (state is AuthorizationLoadingS) {
          return const LoadingWidget();
        }
        if (state is AuthorizationLocalNeedS) {
          return LocalAuthPage(pin: state.pinCode);
        }
        if (state is AuthorizationSuccesS ||
            state is AuthorizationLocalSuccesS) {
          return AuthorizedProvider(child: child);
        }

        return const LoginPage();
      },
    );
  }
}
