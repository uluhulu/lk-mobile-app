import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../widgets/image_picker/attachments_load_error.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../widgets/image_picker/custom_image_picker.dart';
import '../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../../../widgets/loading_widget.dart';
import '../claim_draft_product_bloc/claim_draft_product_cubit.dart';

class ClaimDraftProductFiles extends StatelessWidget {
  const ClaimDraftProductFiles({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  final ClaimDraftProductBloc bloc;
  final ClaimDraftsProductsData data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsFilesCubit, ClaimsFileState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
        if (state is ClaimsFileLoadingS) {
          return const LoadingWidget();
        }
        if (state is ClaimDraftFileLoadedS) {
          return CustomImageAndFilesPicker(
            onAddButton: () => showCustomDialog(
                context: context,
                addImageFromCamera: () {
                  cubit.updateClaimDraftImages(
                    fromGallery: false,
                    claimId: bloc.draftId,
                    productId: data.id,
                    context: context,
                  );
                  bloc.isEditable = true;
                },
                addImageFromGallery: () {
                  cubit.updateClaimDraftImages(
                    fromGallery: true,
                    claimId: bloc.draftId,
                    productId: data.id,
                    context: context,
                  );
                  bloc.isEditable = true;
                }),
            claimDraftFileItems: state.attachment,
            showPicker: true,
            isDeleted: true,
            onDeleteClaimFile: (file) => {},
            claimFile: [],
            onDeleteClaimDraftFile: (ClaimDraftFile image) {
              cubit.deleteImage(id: image.id);
              bloc.isEditable = true;
            },
          );
        }
        if (state is ClaimsFileErrorS) {
          return const AttachmentLoadError();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
