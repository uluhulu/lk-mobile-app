import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';

import '../../../config/theme/elements/theme_data.dart';

class AppErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? callback;
  const AppErrorWidget({
    Key? key,
    this.callback,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icon/info-circle.svg',
            height: 37,
            width: 37,
            color: theme.errorColor,
          ),
          const SizedBox(height: kPadding),
          Text(
            title ?? 'Система временно недоступна',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: kBasePadding),
          Text(
            message ??
                'Возникла ошибка при обработке запроса, попробуйте повторить запрос позже',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: kBasePadding),
          TextButton(
              onPressed: callback,
              child: Text(
                'Обновить',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}

class AppBaseErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? callback;
  const AppBaseErrorWidget({
    Key? key,
    this.callback,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ??
                'Возникла ошибка при обработке запроса, попробуйте повторить запрос позже',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: theme.greyIconColor),
          ),
          const SizedBox(height: kBasePadding),
          TextButton(
              onPressed: callback,
              child: Text(
                'Перезагрузить',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
