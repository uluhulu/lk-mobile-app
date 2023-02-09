import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/loca_auth/views/re_enter_pin_code_page.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/pin_code_success_widget.dart';
import 'package:mkk/presentation/pages/loca_auth/widgets/set_pin_code.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../local_auth_bloc/local_auth_bloc.dart';

class SetPinCodePage extends StatefulWidget {
  const SetPinCodePage({super.key});

  @override
  State<SetPinCodePage> createState() => _SetPinCodePageState();
}

class _SetPinCodePageState extends State<SetPinCodePage> {
  late bool? _isSetPin;
  @override
  initState() {
    super.initState();
    context.read<LocalAuthBloc>().add(LocalAuthInitializeE());
    _isSetPin = sl.get<UserRepository>().getLocalAuthPin() != null;
  }

//  bool _isSetPin() {
//     return sl.get<UserRepository>().getLocalAuthPin() != null;
//   }
  @override
  Widget build(BuildContext context) {
    return ScreenView(
      context: context,
      title: S.of(context).change_code,
      child: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, LocalAuthState state) {
    if (state is LocalAuthEnteredS) {
      return ReEnterPinCodePage(actualPin: state.pin);
    }
    return SetPinCode(
      titleText: S.of(context).come_up_new_code,
      isSetPin: true,
      text: S.of(context).cancel,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _listener(BuildContext context, LocalAuthState state) {
    if (state is LocalAuthSuccessS) {
      Navigator.of(context).pop();
      BaseBottomSheetWidget(
        context: context,
        child: PinCodeSuccessWidget(isFirstEnter: _isSetPin),
      ).show();
    }
  }
}
