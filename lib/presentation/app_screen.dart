import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/authorization/authorization_page.dart';
import 'package:mkk/presentation/pages/banner/banner_widget.dart';
import 'package:mkk/presentation/pages/main/main_screen.dart';
import 'package:mkk/presentation/views/app_injection.dart';
import 'package:mkk/presentation/views/app_provider.dart';

/// Загрузка приложения
class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const AppInjection(
      child: AppProvider(
        child: AuthorizationBuilderWidget(
          child: BannerBuilder(child: MainScreen()),
        ),
      ),
    );
  }
}
