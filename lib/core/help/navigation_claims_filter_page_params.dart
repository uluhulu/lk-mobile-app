import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';

import '../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../data/api/claims/main/entity/claims_entity.dart';
import '../../data/api/help/entity/help_entity.dart';
import '../../presentation/pages/claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../../data/api/help/entity/help_entity.dart';
import '../../presentation/pages/claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import '../../presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../../presentation/widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';

class ClaimsFilterPageParams {
  ClaimsFilterPageParams({
    required this.data,
    required this.bloc,
  });

  final ClaimsEntity data;
  final ClaimsBloc bloc;
}

class ClaimsDraftsListPageParams {
  ClaimsDraftsListPageParams({
    //required this.bloc,
    required this.id,
  });

  //final ClaimDraftsListBloc bloc;
  final int id;
}

class ClaimsDraftsProductInfoParams {
  ClaimsDraftsProductInfoParams({
    required this.bloc,
    required this.data,
    required this.errorCubit,
    required this.id,
  });

  final ClaimDraftsProductsBloc bloc;
  final ClaimDraftsErrorCubit errorCubit;
  final ClaimDraftsProductsData data;
  final int id;
}

class ClaimsDraftsProductsParams {
  ClaimsDraftsProductsParams({
    required this.bloc,
    required this.data,
  });

  final ClaimDraftsProductsBloc bloc;
  final ClaimDraftsProductsEntity data;
}

class ClaimsDraftsAddItemParams {
  ClaimsDraftsAddItemParams({
    required this.bloc,
    required this.id,
  });

  final ClaimDraftAddProductBloc bloc;

  final int id;
}

class CreateClaimDraftParams {
  CreateClaimDraftParams({
    required this.uuid,
  });

  final String uuid;
}

class HelpDetailParams {
  HelpDetailParams({
    required this.content,
    required this.otherContentItems,
    required this.helpTitle,
  });

  final Content content;
  final String helpTitle;
  final List<Content> otherContentItems;
}

class ClaimDraftAddOveragesParams {
  ClaimDraftAddOveragesParams({
    required this.id,
    required this.bloc,
    required this.productsBloc,
    required this.claimErrorBloc,
  });

  final int id;
  final ClaimDraftAddOverageBloc bloc;
  final ClaimDraftsProductsBloc productsBloc;
  final ClaimDraftsErrorCubit claimErrorBloc;
}
