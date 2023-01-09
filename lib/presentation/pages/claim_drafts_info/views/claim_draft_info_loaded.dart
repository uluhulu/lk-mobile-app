import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/widgets/card/claim_draft_header_card.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/widgets/claim_draft_row_buttons.dart';
import 'package:mkk/services/platform.dart';
import '../../../../data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../claim_drafts_products/views/claim_drafts_products.dart';
import '../claim_drafts_bloc/claim_drafts_info_bloc.dart';
import '../widgets/bottom_sheet/claim_draft_save_content.dart';
import '../widgets/claim_draft_delete_button.dart';
import '../widgets/claim_draft_navigation_bar.dart';

class ClaimDraftsInfoLoaded extends StatelessWidget {
  final int id;
  final ClaimDraftsInfoEntity draft;
  final ClaimDraftsProductsEntity claimProducts;

  const ClaimDraftsInfoLoaded({
    Key? key,
    required this.draft,
    required this.id,
    required this.claimProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClaimDraftsInfoData item = draft.data;
    return BlocListener<ClaimDraftsInfoBloc, ClaimDraftsInfoState>(
      listener: _listener,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ClaimDraftHeaderCard(item: item),
                ClaimDraftRowButtons(
                  draftId: id,
                  data: claimProducts,
                ),
                ClaimDraftsProductsProvider(id: item.id),
                ClaimDraftDeleteButton(id: id),
                isAndroid()
                    ? const SizedBox(height: kBasePadding)
                    : const SizedBox(),
              ],
            ),
          ),
          ClaimDraftNavigationBar(id: item.id.toString()),
        ],
      ),
    );
  }

  void _listener(BuildContext context, ClaimDraftsInfoState state) {
    if (state is ClaimDraftsSaveSuccess) {
      BaseBottomSheetWidget(
        context: context,
        child: ClaimDraftSaveContent(
          id: draft.data.id.toString(),
        ),
      ).show();
    }
  }
}
