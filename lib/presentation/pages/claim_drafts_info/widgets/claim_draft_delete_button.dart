import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'claim_draft_delete_content.dart';

class ClaimDraftDeleteButton extends StatelessWidget {
  final int id;
  const ClaimDraftDeleteButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftsInfoBloc>();
    return GestureDetector(
      onTap: () {
        BaseBottomSheetWidget(
          context: context,
          child: BlocProvider.value(
            value: bloc,
            child: ClaimDraftDeleteContent(id: id),
          ),
        ).show();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kBasePadding, horizontal: kBasePadding),
        child: Row(
          children: [
            SvgPicture.asset('assets/icon/trash_empty.svg',
                width: 24, height: 24, color: MyTheme.of(context).errorColor),
            const SizedBox(width: kPadding),
            Text(
              S.of(context).delete_draft,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: MyTheme.of(context).errorColor),
            ),
          ],
        ),
      ),
    );
  }
}
