import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/claims/widgets/search/widgets/claims_search_loaded_card.dart';
import 'package:mkk/presentation/pages/claims/widgets/search/widgets/claims_search_products.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../data/api/claims/main/entity/claims_entity.dart';

class ClaimsSearchLoaded extends StatelessWidget {
  final Data claim;
  const ClaimsSearchLoaded({
    Key? key,
    required this.claim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: kBasePadding),
        ClaimsLoadedHeaderCard(claim: claim),
        const SizedBox(height: kBasePadding),
        SearchClaimProductsProvider(
          uuid: claim.uuid,
        ),
      ],
    );
  }
}
