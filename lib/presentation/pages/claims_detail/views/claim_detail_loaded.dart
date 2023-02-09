import 'package:flutter/material.dart';
import 'package:mkk/data/api/claims/detail/entity/claim_detail_entity.dart';

import '../../../../core/utils/constants.dart';
import '../../claims/widgets/search/widgets/claims_search_loaded_card.dart';
import 'claim_products_list.dart';

class ClaimDetailLoaded extends StatelessWidget {
  final ClaimDetailEntity detailData;
  const ClaimDetailLoaded({
    Key? key,
    required this.detailData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: kBasePadding),
        ClaimsLoadedHeaderCard(
          claim: detailData.data,
        ),
        const SizedBox(height: kBasePadding),
         ClaimProductsList(status: detailData.data.status,),
      ],
    );
  }
}
