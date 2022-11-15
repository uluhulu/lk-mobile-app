import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:mkk/presentation/pages/loca_auth/validate_pin_bloc/validate_pin_bloc.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/login_screen_view.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../domain/use_cases/user/local_auth_use_case.dart';

class LocalAuthPage extends StatefulWidget {
  final String pin;
  const LocalAuthPage({
    Key? key,
    required this.pin,
  }) : super(key: key);

  @override
  _LocalAuthPageState createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  bool fingerPrint = false;
  String actualPin = '';
  String get pin => bloc.pin;

  ValidatePinBloc bloc = ValidatePinBloc();

  @override
  void initState() {
    final userRepo = context.read<UserRepository>();
    final actualPinUseCase = GetLocalAuthUseCase(userRepo);

    actualPin = actualPinUseCase.call().toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenView(
        body: BlocProvider(
      create: (context) => bloc,
      child: PinCodeWidget(
        isSetPin: false,
        titleText: S.of(context).enter_pin_code,
        incorrectCode: S.of(context).incorrect_code,
        buttonText: S.of(context).enter_for_log_pass,
        onPressed: () {
          context.read<AuthorizationBloc>().add(
                AuthorizationDeleteLocalAuthE(),
              );
          //context.read<BannerBloc>().add(BannerSetPinShowedE());
        },
        rightButton: rightButton,
        pinEntered: pinEntered,
      ),
    ));
  }

  Widget rightButton(String pin) {
    if (pin.isNotEmpty) {
      return PinButton(
          iconSize: 60,
          size: 40,
          icon: SvgPicture.asset('assets/icon/remove_button.svg'),
          onPressed: () {
            bloc.add(ValidatePinRemoveE());
          });
    } else {
      if (fingerPrint) {
        return PinButton(
            iconSize: 60,
            size: 40,
            icon: SvgPicture.asset('assets/icon/remove_button.svg'),
            onPressed: () async {});
      } else {
        return const SizedBox(
          width: 60,
          height: 60,
        );
      }
    }
  }

  void pinEntered(String pinInt) {
    dev.log('Actual($actualPin), Pin($pinInt)');
    if (actualPin == pinInt) {
      BlocProvider.of<AuthorizationBloc>(context).add(AuthorizationRightPinE());
    } else {
      bloc.add(ValidatePinErrorE());
    }
  }
}
