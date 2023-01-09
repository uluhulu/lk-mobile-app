import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottie/loader_small.json',
            width: 150,
            height: 150,
          ),
        )
      ],
    );
  }
}

class SmallLoadingWidget extends StatelessWidget {
  const SmallLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottie/loader_small.json',
            width: 100,
            height: 100,
          ),
        )
      ],
    );
  }
}

class LoadingPage extends StatelessWidget {
  final String title;
  const LoadingPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      context: context,
      title: title,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/loader_small.json',
              width: 150,
              height: 150,
            ),
          )
        ],
      ),
    );
  }
}
