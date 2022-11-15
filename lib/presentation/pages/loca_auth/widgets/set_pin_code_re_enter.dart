// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_widget.dart';
import 'package:mkk/services/logger/logger_service.dart';
import '../local_auth_bloc/local_auth_bloc.dart';
import '../validate_pin_bloc/validate_pin_bloc.dart';

class SetPinCodeReEnter extends StatelessWidget {
  final String actualPin;
  const SetPinCodeReEnter({
    Key? key,
    required this.actualPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidatePinBloc>(
      create: _createBloc,
      child: ReEnterPinPage(actualPin: actualPin),
    );
  }

  ValidatePinBloc _createBloc(BuildContext context) {
    return ValidatePinBloc();
  }
}

class ReEnterPinPage extends StatefulWidget {
  final String actualPin;
  const ReEnterPinPage({
    Key? key,
    required this.actualPin,
  }) : super(key: key);

  @override
  State<ReEnterPinPage> createState() => _ReEnterPinPageState();
}

class _ReEnterPinPageState extends State<ReEnterPinPage> {
  String get actualPin => widget.actualPin;

  @override
  Widget build(BuildContext context) {
    return PinCodeWidget(
      titleText: S.of(context).repeat_pin_code,
      incorrectCode: S.of(context).repeat_pin_code_error,
      rightButton: rightButton,
      pinEntered: pinEntered,
      isSetPin: false,
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

  void pinEntered(String pinInt) {
    L.i('Actual($actualPin), Pin($pinInt)');
    if (actualPin == pinInt) {
      BlocProvider.of<LocalAuthBloc>(context)
          .add(LocalAuthReEnterE(pin: pinInt));
    } else {
      context.read<ValidatePinBloc>().add(ValidatePinErrorE());
    }
  }
}
