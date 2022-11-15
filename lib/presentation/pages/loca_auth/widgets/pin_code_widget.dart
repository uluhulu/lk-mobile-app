import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_error_sheet.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_error_subtitle_widget.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_error_widget.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_subtitle_widget.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../local_auth_bloc/local_auth_bloc.dart';
import '../validate_pin_bloc/validate_pin_bloc.dart';

typedef WidgetFunction = Widget Function(String);

typedef PinEnteredFunction = void Function(String);

class PinCodeWidget extends StatefulWidget {
  final String? errorSubtitleText;
  final String? titleText;
  final String? subTitleText;
  final String? buttonText;
  final String? incorrectCode;
  final VoidCallback? onPressed;
  final WidgetFunction? leftButton;
  final WidgetFunction? rightButton;
  final PinEnteredFunction? pinEntered;
  final bool isSetPin;

  const PinCodeWidget({
    Key? key,
    this.leftButton,
    this.rightButton,
    this.pinEntered,
    this.errorSubtitleText,
    this.titleText,
    this.subTitleText,
    this.buttonText,
    this.onPressed,
    this.incorrectCode,
    required this.isSetPin,
  }) : super(key: key);

  @override
  _PinCodeWidgetState createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  late ValidatePinBloc bloc;
  WidgetFunction get leftButton =>
      widget.leftButton ??
      (String) {
        return const SizedBox(
          width: 60,
          height: 60,
        );
      };
  WidgetFunction get rightButton =>
      widget.rightButton ??
      (String) {
        return const SizedBox(
          width: 60,
          height: 60,
        );
      };
  PinEnteredFunction get pinEntered => widget.pinEntered ?? (String) {};
  int get maxPinLength => bloc.maxLength;
  bool fingerPrint = false;
  int pinLength = 0;
  @override
  void initState() {
    bloc = BlocProvider.of<ValidatePinBloc>(context);
    bloc.streamController.stream.listen((event) {
      final pin = event;
      if (pin.isEmpty || pin == '') return;
      if (event.length == maxPinLength) {
        pinEntered(pin);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValidatePinBloc, ValidatePinState>(
      bloc: bloc,
      builder: (context, state) {
        bool hasError = false;
        bool showErrorBanner = false;
        pinLength = state.pin.length;
        hasError = state.hasError;
        showErrorBanner = state.showErrorBanner;
        dev.log('PinWidget(error: $hasError, pin: ${state.pin})');
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(flex: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                widget.titleText ?? '',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
            widget.subTitleText != null
                ? PinCodeSubTitleWidget(subtitle: widget.subTitleText)
                : const SizedBox.shrink(),
            PinErrorWidget(
              hasError: hasError,
              incorrectCode: widget.incorrectCode ?? '',
            ),
            widget.errorSubtitleText != null
                ? PinCodeErrorSubTitleWidget(
                    errorSubtitle: widget.errorSubtitleText,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: kPadding * 2),
            buildPinDots(hasError),
            const Spacer(flex: 3),
            SizedBox(
              height: 400,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kBasePadding * 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: buildRows(12, state.pin),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.onPressed?.call();
              },
              child: widget.buttonText != null
                  ? Text(
                      widget.buttonText ?? '',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: MyTheme.of(context).primaryButtonColor,
                          ),
                    )
                  : const SizedBox.shrink(),
            ),
            const Spacer(flex: 2),
          ],
        );
      },
      listener: _listener,
    );
  }

  Widget buildRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

  Widget buildButton(int index, String pin) {
    if (index == 10) {
      return leftButton(pin);
    } else if (index == 11) {
      return PinButton(
        onPressed: () {
          bloc.add(ValidatePinPrintE('0'));
        },
        text: '0',
      );
    } else if (index == 12) {
      return rightButton(pin);
    } else {
      return PinButton(
        onPressed: () {
          bloc.add(ValidatePinPrintE('$index'));
        },
        text: '$index',
      );
    }
  }

  List<Widget> buildRows(int numChilds, String pin) {
    List<Widget> children = [];
    List<Widget> rows = [];
    for (var i = 0; i <= numChilds; i++) {
      if (i % 3 == 0) {
        rows.add(buildRow(children));
        children = [];
      }
      children.add(buildButton(i + 1, pin));
    }
    return rows;
  }

  Widget buildPinDots(bool hasError) {
    List<Widget> children = [];
    for (var i = 0; i < maxPinLength; i++) {
      if (i < pinLength) {
        children.add(SvgPicture.asset(
          hasError ? 'assets/icon/error_dot.svg' : 'assets/icon/dot_gr.svg',
          width: 19,
          height: 19,
        ));
      } else {
        children.add(SvgPicture.asset(
          'assets/icon/dot.svg',
          width: 16,
          height: 16,
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBasePadding * 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }

  void _listener(BuildContext context, ValidatePinState state) {
    final bannerBloc = BlocProvider.of<BannerBloc>(context);
    final localAuthBloc = BlocProvider.of<LocalAuthBloc>(context);
    if (state.showErrorBanner == true) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSheetBorderRadius),
            topRight: Radius.circular(kSheetBorderRadius),
          ),
        ),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        builder: (currentContext) => BlocProvider.value(
          value: bannerBloc,
          child: BlocProvider.value(
            value: localAuthBloc,
            child: PinCodeErrorSheet(isSetPin: widget.isSetPin),
          ),
        ),
      );
    }
  }
}

class PinButton extends StatefulWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback onPressed;
  final double size;
  final double fontSize;
  final double iconSize;
  const PinButton({
    Key? key,
    this.size = 60,
    this.fontSize = 30,
    this.iconSize = 60,
    this.text,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _PinButtonState createState() => _PinButtonState();
}

class _PinButtonState extends State<PinButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.zero,
      iconSize: widget.iconSize,
      alignment: Alignment.center,
      icon: widget.icon != null
          ? Container(
              width: widget.size,
              height: widget.size,
              alignment: Alignment.center,
              child: widget.icon,
            )
          : Container(
              width: widget.size,
              height: widget.size,
              alignment: Alignment.center,
              child: Text(
                widget.text ?? '',
                style: TextStyle(fontSize: widget.fontSize),
              ),
            ),
    );
  }
}
