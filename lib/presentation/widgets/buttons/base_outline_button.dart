import '../../../core/utils/constants.dart';
import 'package:flutter/material.dart';

// кнопка
class BaseOutlineButton extends StatelessWidget {
  const BaseOutlineButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.canPress = true,
    this.isLoading = false,
    this.btnHeight = 50,
    this.btnWidth = double.infinity,
    this.color,
    this.withoutCardView = false,
    this.backgroundColor,
    this.style,
    this.icon,
    this.iconTextPadding,
    this.textStyle,
  }) : super(key: key);

  final bool canPress;
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double btnHeight;
  final double btnWidth;
  final Color? color;
  final bool withoutCardView;
  final Color? backgroundColor;
  final ButtonStyle? style;
  final Widget? icon;
  final double? iconTextPadding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: OutlinedButton(
        onPressed: _enabled == true ? onPressed : null,
        style: style ??
            OutlinedButton.styleFrom(
              side: const BorderSide(width: 1, color: Colors.black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              //onSurface: blueColor,
              elevation: 0,
            ),
        child: _buildText(),
      ),
    );
  }

  Widget _buildText() {
    if (isLoading == true) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      );
      // return SizedBox(
      //   width: btnHeight / 2,
      //   height: btnHeight / 3,
      //   child: const CircularProgressIndicator(
      //     valueColor: AlwaysStoppedAnimation<Color>(blueColor),
      //   ),
      // );
    }

    return SizedBox(
      height: btnHeight,
      child: icon == null
          ? Center(
              child: FittedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      const TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.w400),
                ),
              ),
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  SizedBox(width: iconTextPadding ?? 8),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
    );
  }

  bool get _enabled => canPress == true && isLoading == false;
}
