import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/widgets/claim_drafts_delete_accept.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../claim_drafts_list_bloc/claim_drafts_list_bloc.dart';

class ClaimDraftsDeleteButton extends StatelessWidget {
  const ClaimDraftsDeleteButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftsListBloc>();
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          BaseBottomSheetWidget(
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: ClaimDraftsDeleteAccept(id: id),
            ),
          ).show();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kBasePadding),
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
      ),
    );
  }
}


///Вариант кнопки
  //  return TextButton.icon(
  //     onPressed: () {
  //       BaseBottomSheetWidget(
  //         context: context,
  //         child: BlocProvider.value(
  //           value: bloc,
  //           child: ClaimDraftsDeleteAccept(id: id),
  //         ),
  //       ).show();
  //     },
  //     style: TextButton.styleFrom(
  //       padding: const EdgeInsets.symmetric(vertical: kBasePadding * 2),
  //       maximumSize: const Size(300, double.infinity),
  //     ),
  //     icon: SvgPicture.asset('assets/icon/trash_empty.svg',
  //         width: 24, height: 24, color: MyTheme.of(context).errorColor),
  //     label: Text(
  //       S.of(context).delete_draft,
  //       style: Theme.of(context)
  //           .textTheme
  //           .headline3
  //           ?.copyWith(color: MyTheme.of(context).errorColor),
  //     ),
  //   );
  //   return GestureDetector(
  //     onTap: () {
  //       BaseBottomSheetWidget(
  //         context: context,
  //         child: BlocProvider.value(
  //           value: bloc,
  //           child: ClaimDraftsDeleteAccept(id: id),
  //         ),
  //       ).show();
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: kBasePadding),
  //       child: Row(
  //         children: [
  //           SvgPicture.asset('assets/icon/trash_empty.svg',
  //               width: 24, height: 24, color: MyTheme.of(context).errorColor),
  //           const SizedBox(width: kPadding),
  //           Text(
  //             S.of(context).delete_draft,
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .headline3
  //                 ?.copyWith(color: MyTheme.of(context).errorColor),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );