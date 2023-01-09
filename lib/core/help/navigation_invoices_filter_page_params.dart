import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';

import '../../data/api/invoices/list/entity/invoices_entity.dart';

class InvoicesFilterPageParams {
  InvoicesFilterPageParams({
    required this.data,
    required this.bloc,
  });

  final InvoicesEntity data;
  final InvoicesBloc bloc;
}
