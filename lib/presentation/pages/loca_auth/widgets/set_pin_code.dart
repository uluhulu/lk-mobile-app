import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../local_auth_bloc/local_auth_bloc.dart';
import '../validate_pin_bloc/validate_pin_bloc.dart';
import 'pin_code_widget.dart';

class SetPinCode extends StatelessWidget {
  final bool isSetPin;
  final String? text;
  final VoidCallback? onPressed;
  final String? titleText;
  const SetPinCode({
    Key? key,
    this.onPressed,
    this.text,
    required this.isSetPin,
    this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidatePinBloc>(
      create: _createBloc,
      child: SetNewPinCodeWidget(
        titleText: titleText,
        isSetPin: isSetPin,
        onPressed: onPressed,
        text: text,
      ),
    );
  }

  ValidatePinBloc _createBloc(BuildContext context) {
    return ValidatePinBloc();
  }
}

class SetNewPinCodeWidget extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isSetPin;
  final String? titleText;
  const SetNewPinCodeWidget({
    Key? key,
    this.text,
    this.onPressed,
    this.isSetPin = false,
    this.titleText,
  }) : super(key: key);

  @override
  State<SetNewPinCodeWidget> createState() => _SetNewPinCodeWidgetState();
}

class _SetNewPinCodeWidgetState extends State<SetNewPinCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return PinCodeWidget(
      isSetPin: widget.isSetPin,
      titleText: widget.titleText ?? S.of(context).come_up_pin_code,
      subTitleText:
          widget.isSetPin == false ? S.of(context).come_up_pin_code_info : null,
      buttonText:
          widget.isSetPin == true ? widget.text : S.of(context).skip_step,
      onPressed: widget.isSetPin == true
          ? widget.onPressed
          : () {
              context.read<BannerBloc>().add(BannerSetPinShowedE());
            },
      rightButton: rightButton,
      pinEntered: pinEntered,
    );
  }

  Widget rightButton(String pin) {
    if (pin.isNotEmpty) {
      return PinButton(
          iconSize: 60,
          size: 40,
          icon: SvgPicture.asset('assets/icon/remove_button.svg'),
          onPressed: () {
            context.read<ValidatePinBloc>().add(ValidatePinRemoveE());
          });
    } else {
      return const SizedBox(
        width: 60,
        height: 60,
      );
    }
  }

  void pinEntered(String pin) {
    context.read<LocalAuthBloc>().add(LocalAuthEnteredE(pin: pin));
  }
}
