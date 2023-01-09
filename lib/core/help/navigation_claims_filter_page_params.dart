import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';

import '../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../data/api/claims/main/entity/claims_entity.dart';
import '../../presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';

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
  });

  final ClaimDraftsProductsBloc bloc;
  final ClaimDraftsProductsData data;
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
