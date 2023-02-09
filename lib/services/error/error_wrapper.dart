import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';

import '../../core/help/launch_url_helper.dart';
import '../../core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../presentation/widgets/buttons/primary_elevated_button.dart';
import 'bloc/error_bloc.dart';

class ErrorWrapper extends StatelessWidget {
  final Widget child;
  const ErrorWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ErrorListener(child: child);
  }
}

class ErrorListener extends StatelessWidget {
  final Widget child;
  const ErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorBloc, ErrorState>(
      listener: (context, state) async {
        if (state is ErrorNotificationS) {
          await Future.delayed(const Duration(milliseconds: 500), () {
            BaseBottomSheetWidget(
                context: context,
                needMenu: false,
                child: Container(
                  padding: _padding(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/info-circle.svg',
                        width: 36,
                        height: 36,
                        color: Colors.red,
                      ),
                      const SizedBox(height: kPadding / 2),
                      Text(
                        state.title ?? 'Ошибка!',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: kBasePadding),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 5,
                      ),
                      const SizedBox(height: kBasePadding * 3),
                      PrimaryElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Понятно',
                      )
                    ],
                  ),
                )).show();
          });
        }
        if (state is AuthErrorS) {
          await Future.delayed(const Duration(milliseconds: 400), () {
            BaseBottomSheetWidget(
                context: context,
                child: ListView(
                  padding: _padding(),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/info-circle.svg',
                          width: 36,
                          height: 36,
                          color: Colors.red,
                        ),
                        const SizedBox(height: kBasePadding),
                        Text(
                          S.of(context).auth_error,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    const SizedBox(height: kBasePadding),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: state.message,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextSpan(
                              text: ' help@puls.ru',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: Colors.blue,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  LaunchUrlHelper.launchHelpEmail(
                                    S.of(context).puls_email,
                                  );
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(height: kBasePadding),
                    Text(
                      state.subtitle ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: kBasePadding * 3),
                    PrimaryElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Понятно',
                    )
                  ],
                )).show();
          });
        }
      },
      child: child,
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}
