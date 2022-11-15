import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import '../loca_auth/set_pin_code_builder.dart';

class BannerProvider extends StatelessWidget {
  final Widget child;
  const BannerProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BannerBloc>(
      create: (context) => BannerBloc(),
      child: child,
    );
  }
}

class BannerBuilder extends StatelessWidget {
  final Widget child;
  const BannerBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerShowS) {
          return const SetPinCodeBuilder();
        }
        return child;
      },
    );
  }
}
