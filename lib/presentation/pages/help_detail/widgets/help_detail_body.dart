import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mkk/core/utils/constants.dart';

class HelpDetailBody extends StatelessWidget {
  final String htmlContent;

  const HelpDetailBody({Key? key, required this.htmlContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: kPadding,
      ),
      child: HtmlWidget(
        htmlContent,
        textStyle: const TextStyle(fontSize: 16),
        // shrinkWrap: true,
        // data: htmlContent,
        // style: {
        //   "p": Style(
        //     fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
        //     fontSize: FontSize(16),
        //     padding: EdgeInsets.zero,
        //   ),
        //   "body": Style(
        //     fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
        //     fontSize: FontSize(16),
        //     padding: EdgeInsets.zero,
        //   ),
        //   // "div": Style(
        //   //   // textDecorationStyle: TextDecorationStyle,
        //   //   // textDecoration: TextDecoration.
        //   //   fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
        //   //   fontSize: FontSize(16),
        //   //   // fontStyle: FontStyle
        //   //   color: MyTheme.of(context).htmlDialogColor,
        //   //   backgroundColor: MyTheme.of(context).htmlDialogBackGroundColor,
        //   // ),
        // },
      ),
    );
  }
}
