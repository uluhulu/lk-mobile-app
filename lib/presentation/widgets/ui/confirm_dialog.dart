import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

/// Диалоговое окно подтверждения действия
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.titleText,
    this.contentText,
    this.confirmButtonText,
    required this.isFirst,
    required this.confirmCallback,
  }) : super(key: key);

  final bool isFirst;
  final String? titleText;
  final String? contentText;
  final String? confirmButtonText;
  final VoidCallback confirmCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(8),
      elevation: 2,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      title: titleText != null ? Text(titleText!) : null,
      content: contentText != null ? Text(contentText!) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            confirmCallback.call();
            isFirst
                ? Navigator.of(context)
                    .popUntil((Route<dynamic> route) => route.isFirst)
                : Navigator.pop<bool>(context, true);
          },
          child: Text(confirmButtonText ?? 'Подтвердить'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            Navigator.pop<bool>(context, true);
          },
          child: const Text(
            'Закрыть',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
