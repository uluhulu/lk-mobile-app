import 'package:flutter/material.dart';

class HelpDetailTitle extends StatelessWidget {
  final String title;

  const HelpDetailTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: 24,
            ),
      ),
    );
  }
}
