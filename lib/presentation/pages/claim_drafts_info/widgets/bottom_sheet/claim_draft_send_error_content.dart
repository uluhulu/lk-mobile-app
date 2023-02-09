import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_drafts/send/entity/claim_drafts_send_error_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/text/text_with_copy.dart';

class ClaimDraftSendErrorContent extends StatelessWidget {
  final String? message;
  final ClaimsDraftSendError? data;
  const ClaimDraftSendErrorContent({
    super.key,
    this.message,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _content(context),
          _backButton(context),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          _iconTitle(context),
          const SizedBox(height: kBasePadding),
          Text(
            S.of(context).claim_draft_error,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: kBasePadding),
          message != null
              ? Text(
                  message ?? '',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              : _errorList(),
          const SizedBox(height: kBasePadding * 3),
        ],
      ),
    );
  }

  Widget _errorList() {
    return ListView.separated(
      separatorBuilder: _titleSeparatorBuilder,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final key = data?.errors.keys.toList()[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWithCopy(
              data?.errors[key]?.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: kPadding),
            _productsErrorList(key),
          ],
        );
      },
      itemCount: data?.errors.length ?? 0,
      shrinkWrap: true,
    );
  }

  Widget _productsErrorList(String? key) {
    return ListView.separated(
        itemCount: data?.errors[key]?.errors.length ?? 0,
        separatorBuilder: _subtitleSeparatorBuilder,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: kPadding),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TextWithCopy(
            '• ${data?.errors[key]?.errors[index].message}',
            style: Theme.of(context).textTheme.bodyText1,
          );
        });
  }

  Widget _backButton(BuildContext context) {
    return PrimaryElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: S.of(context).ok,
    );
  }

  Widget _iconTitle(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/info-circle.svg',
          height: 40,
          width: 40,
          color: MyTheme.of(context).errorColor,
        ),
        const SizedBox(height: kPadding),
        Text(
          S.of(context).claim_draft_error_send,
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
      ],
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

  Widget _titleSeparatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: kBasePadding);
  }

  Widget _subtitleSeparatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: kPadding);
  }
}
