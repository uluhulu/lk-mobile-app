import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/loca_auth/local_auth_bloc/local_auth_bloc.dart';

import '../banner/banner_widget.dart';
import 'authorization_bloc/authorization_bloc.dart';

class AuthorizedProvider extends StatelessWidget {
  final Widget child;
  const AuthorizedProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerBuilder(child: child);
  }
}
