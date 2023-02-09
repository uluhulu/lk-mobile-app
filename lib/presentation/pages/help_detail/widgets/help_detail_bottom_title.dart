import 'package:flutter/material.dart';

class HelpDetailBottomTitle extends StatelessWidget {
  final String title;
   double? fontSize;

   HelpDetailBottomTitle({Key? key, required this.title, this.fontSize = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
          fontSize: fontSize,
        ),
      ),
    );
  }
}
