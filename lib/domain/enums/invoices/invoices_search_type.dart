import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';

enum InvoicesSearchType {
  invoice,
  customerOrder,
  electronicOrder,
}

extension InvoicesSearchTypeX on InvoicesSearchType {
  Widget get name {
    switch (this) {
      case InvoicesSearchType.invoice:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/receipt-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру накладной'))
        ]);
      case InvoicesSearchType.customerOrder:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/box-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру заказа покупателя'))
        ]);

      case InvoicesSearchType.electronicOrder:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/bag-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру интернет-заказа'))
        ]);
    }
  }
}

extension ClaimsSearchTypeX on InvoicesSearchType {
  Widget get claimName {
    switch (this) {
      case InvoicesSearchType.invoice:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/receipt-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру претензии'))
        ]);
      case InvoicesSearchType.customerOrder:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/box-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру заказа покупателя'))
        ]);

      case InvoicesSearchType.electronicOrder:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/bag-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру интернет-заказа'))
        ]);
    }
  }
}

class InvoicesSearchTypeParser {
  static String searchBy(InvoicesSearchType type) {
    switch (type) {
      case InvoicesSearchType.invoice:
        return 'invoice';
      case InvoicesSearchType.customerOrder:
        return 'customer_order';
      case InvoicesSearchType.electronicOrder:
        return 'electronic_order';
    }
  }

  static String searchByToString(InvoicesSearchType type) {
    switch (type) {
      case InvoicesSearchType.invoice:
        return 'Искать номер накладной';
      case InvoicesSearchType.customerOrder:
        return 'Искать заказ покупателя';
      case InvoicesSearchType.electronicOrder:
        return 'Искать интернет-заказ';
    }
  }

  static String searchTypeToStringWithError(InvoicesSearchType type) {
    switch (type) {
      case InvoicesSearchType.invoice:
        return 'номеру товарной накладной';
      case InvoicesSearchType.customerOrder:
        return 'номеру заказа покупателя';
      case InvoicesSearchType.electronicOrder:
        return 'номеру интернет-заказа';
    }
  }
}
