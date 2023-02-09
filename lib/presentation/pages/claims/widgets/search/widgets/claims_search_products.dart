import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/repositories/repository.dart';
import '../../../../../../locator/locator.dart';
import '../../../../claims_detail/claim_products_bloc/claim_products_bloc.dart';
import '../../../../claims_detail/views/claim_products_list.dart';

class SearchClaimProductsProvider extends StatelessWidget {
  final String uuid;
  const SearchClaimProductsProvider({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimProductsBloc>(
      create: _createProductsBloc,
      child:  ClaimProductsList(),
    );
  }

  ClaimProductsBloc _createProductsBloc(BuildContext context) {
    return ClaimProductsBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }
}
