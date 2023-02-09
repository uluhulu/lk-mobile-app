import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/main/navigation_bar_bloc/home_navigation_bar.dart';
import 'package:mkk/presentation/pages/main/views/main_content.dart';
import 'package:mkk/presentation/pages/main/views/main_navigation_bar.dart';
import 'package:mkk/presentation/pages/main/views/main_navigator.dart';

/// Главный экран
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainNavigator(
      child: BlocProvider<HomeNavigationBarBloc>(
        create: _createNavigationBloc,
        child: const Scaffold(
          bottomNavigationBar: MainNavigationBar(),
          body: MainContent(),
        ),
      ),
    );
  }

  HomeNavigationBarBloc _createNavigationBloc(BuildContext context) {
    return HomeNavigationBarBloc();
  }
}
