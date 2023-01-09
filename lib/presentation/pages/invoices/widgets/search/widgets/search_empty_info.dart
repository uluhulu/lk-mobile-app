import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../../../domain/enums/invoices/invoices_search_type.dart';
import '../../../invoices_search_bloc/invoices_search_bloc.dart';

class SearchEmptyInfo extends StatelessWidget {
  const SearchEmptyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesSearchBloc>();
    return _errorText(context, bloc);
  }

  Widget _errorText(BuildContext context, InvoicesSearchBloc bloc) {
    final InvoicesSearchType invoiceSearchType =
        bloc.type.value ?? InvoicesSearchType.invoice;

    final String typeText =
        InvoicesSearchTypeParser.searchTypeToStringWithError(invoiceSearchType);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).invoice_search_error,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                  text: '$typeText. ',
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextSpan(
                  text: _errorTextWithType(context, bloc),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                    text: 'Поиск накладной',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: MyTheme.of(context).primaryButtonColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                        //TODO: добавить переход в справку
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _errorTextWithType(BuildContext context, InvoicesSearchBloc bloc) {
    final InvoicesSearchType type =
        bloc.type.value ?? InvoicesSearchType.invoice;

    switch (type) {
      case InvoicesSearchType.invoice:
        return S.of(context).invoice_search_error_by_number;
      case InvoicesSearchType.electronicOrder:
        return S.of(context).invoice_search_error_by_internet_order;
      case InvoicesSearchType.customerOrder:
        return S.of(context).invoice_search_error_by_order;

      default:
        return S.of(context).invoice_search_error_by_number;
    }
  }
}
