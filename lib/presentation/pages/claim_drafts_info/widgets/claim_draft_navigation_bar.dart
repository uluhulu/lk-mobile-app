import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/services/platform.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import 'bottom_sheet/claim_draft_save_content.dart';
import 'bottom_sheet/claim_draft_send_content.dart';

class ClaimDraftNavigationBar extends StatelessWidget {
  final String id;
  const ClaimDraftNavigationBar({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      decoration: _decoration(),
      child: Column(
        children: [
          Row(
            children: [
              ClaimDraftSaveButton(id: id, myColors: myColors),
              const SizedBox(width: kBasePadding),
              ClaimDraftSendButton(myColors: myColors),
            ],
          ),
          isIOS()
              ? const SizedBox(height: kBasePadding)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.09),
          spreadRadius: 0,
          blurRadius: 20,
          offset: const Offset(0, -1),
        ),
      ],
    );
  }
}

class ClaimDraftSendButton extends StatelessWidget {
  const ClaimDraftSendButton({
    Key? key,
    required this.myColors,
  }) : super(key: key);

  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ClaimDraftsInfoBloc>(context);
    return Expanded(
      child: PrimaryElevatedButton(
        icon: SvgPicture.asset(
          'assets/icon/sms-tracking.svg',
          color: myColors.whiteColor,
          width: 24,
          height: 24,
        ),
        onPressed: () {
          BaseBottomSheetWidget(
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: const ClaimDraftSendContent(),
            ),
          ).show();
        },
        text: S.of(context).send,
      ),
    );
  }
}

class ClaimDraftSaveButton extends StatelessWidget {
  final String id;
  const ClaimDraftSaveButton({
    Key? key,
    required this.myColors,
    required this.id,
  }) : super(key: key);

  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          context.read<ClaimDraftsInfoBloc>().add(ClaimDraftsInfoSaveE());
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 29),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(width: kPadding),
            _btText(context),
          ],
        ),
      ),
    );
  }

  Widget _btText(BuildContext context) {
    return Text(
      S.of(context).save,
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: myColors.successColor,
          ),
    );
  }

  Widget _icon() {
    return SvgPicture.asset(
      'assets/icon/ram-2.svg',
      color: myColors.successColor,
      width: 24,
      height: 24,
    );
  }
}
