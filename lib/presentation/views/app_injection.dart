import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mkk/data/providers/api_provider.dart';
import '../../data/providers/repositories/network_info_impl.dart';
import '../../data/providers/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../locator/locator.dart';

/// Внедряем глобальные зависимости
class AppInjection extends StatelessWidget {
  const AppInjection({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<Repository>(create: (_) => _registerRepo()),
        RepositoryProvider<UserRepository>(
          create: (_) => sl.get<UserRepository>(),
        ),
      ],
      child: child,
    );
  }

  Repository _registerRepo() {
    final repo = RepositoryImpl(
      networkInfo: NetworkInfoImpl(
        connectionChecker: InternetConnectionChecker(),
      ),
      userRepository: sl.get<UserRepository>(),
    );
    return repo;
  }
}
