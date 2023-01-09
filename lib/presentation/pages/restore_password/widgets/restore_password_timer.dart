import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../restore_password_bloc/restore_password_bloc.dart';
import 'modals/code_expired_modal_content.dart';

class RestorePasswordTimer extends StatefulWidget {
  const RestorePasswordTimer({super.key});

  @override
  State<RestorePasswordTimer> createState() => _RestorePasswordTimerState();
}

class _RestorePasswordTimerState extends State<RestorePasswordTimer> {
  int repeat = 1;

  @override
  void initState() {
    super.initState();
    _updateTimer();
    timerController.addListener(_timeListener);
  }

  @override
  void dispose() {
    timerController.removeListener(_timeListener);
    super.dispose();
  }

  static int endTime =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch;

  CountdownTimerController timerController =
      CountdownTimerController(endTime: endTime);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RestorePasswordBloc>();
    return BlocListener<RestorePasswordBloc, RestorePasswordState>(
      listener: _blocListener,
      child: CountdownTimer(
        controller: timerController,
        widgetBuilder: (context, timer) {
          if (timer == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    child: Text(
                      S.of(context).get_new_code,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: MyTheme.of(context).primaryButtonColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    onPressed: () {
                      bloc.add(RestorePasswordSendE());
                      bloc.code.text = '';
                      _updateTimer();
                    }),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: kPadding),
            child: Text(
              '${S.of(context).remindRequest} ${timerFormat(timer)}',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: MyTheme.of(context).spaceGrey),
            ),
          );
        },
      ),
    );
  }

  String timerFormat(CurrentRemainingTime time) {
    if (time.min == null && time.sec != null) {
      return '0:${time.sec! > 9 ? time.sec : '0${time.sec}'}';
    } else if (time.min != null) {
      return '${time.min}:${time.sec! > 9 ? time.sec : '0${time.sec}'}';
    } else {
      return '0:00';
    }
  }

  void _updateTimer() {
    repeat = repeat + 1;
    endTime =
        DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch;
    timerController = CountdownTimerController(endTime: endTime);
    timerController.start();
  }

  void _timeListener() async {
    final time = timerController.currentRemainingTime;
    if (time == null) return;
    final min = time.min;
    final sec = time.sec;
    if (sec == null) return;
    if (min == null && sec <= 1) {
      await codeExpiredSheet(context);
    }
  }

  void _blocListener(BuildContext context, RestorePasswordState state) {
    if (state is RestorePasswordLoadingS) {
      if (mounted) return;
      _updateTimer();
    }
  }
}

Future<void> codeExpiredSheet(BuildContext context) async {
  final bloc = context.read<RestorePasswordBloc>();
  await Future.delayed(const Duration(seconds: 1), () {
    BaseBottomSheetWidget(
      context: context,
      needMenu: false,
      child: BlocProvider.value(
        value: bloc,
        child: const CodeExpiredContent(),
      ),
    ).show();
  });
}
