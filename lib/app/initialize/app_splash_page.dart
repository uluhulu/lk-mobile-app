import 'package:flutter/material.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import '../../presentation/widgets/scaffold/status_bar_settings.dart';

class AppSplashPage extends StatefulWidget {
  const AppSplashPage({Key? key}) : super(key: key);

  @override
  State<AppSplashPage> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).primaryButtonColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: MyTheme.of(context).primaryButtonColor,
        systemOverlayStyle: StatusBarSettings.settings(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/main_white.json',
            animate: true,
            repeat: true,
          ),
          const SizedBox(height: kPadding * 3),
        ],
      ),
    );
  }
}

class StaticSplashPage extends StatelessWidget {
  const StaticSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).primaryButtonColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: MyTheme.of(context).primaryButtonColor,
        systemOverlayStyle: StatusBarSettings.settings(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash.png',
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: kBasePadding),
        ],
      ),
    );
  }
}


