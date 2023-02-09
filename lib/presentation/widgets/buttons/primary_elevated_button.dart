import '../../../config/theme/elements/theme_data.dart';
import '../../../core/utils/constants.dart';
import 'package:flutter/material.dart';

// кнопка
class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
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
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: _enabled == true ? onPressed : null,
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: backgroundColor?? MyTheme.of(context).primaryButtonColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius)),
              elevation: 0,
            ),
        child: _buildText(),
      ),
    );
  }

  Widget _buildText() {
    if (isLoading == true) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return SizedBox(
      height: btnHeight,
      child: icon == null
          ? Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? const SizedBox.shrink(),
                const SizedBox(width: kPadding),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
    );
  }

  bool get _enabled => canPress == true && isLoading == false;
}
