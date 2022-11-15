import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/restore_password/widgets/restore_password_region_company_list.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/fields/custom_input_decoration.dart';
import '../../../widgets/modal/modal_bottom_sheet_widget.dart';
import '../../authorization/widgets/modal_sheet_title_widget.dart';
import '../restore_password_bloc/restore_password_bloc.dart';

class RestorePasswordRegionCompanyField extends StatelessWidget {
  final RestorePasswordLoadedS state;
  final RestorePasswordBloc bloc;
  const RestorePasswordRegionCompanyField({
    Key? key,
    required this.state,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: TextField(
        enabled: false,
        decoration: CustomInputDecoration(
            hintText: state.company.id == 2 ? 'Не выбрано' : state.company.name,
            hintStyle: state.company.id == 2
                ? null
                : TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
            myColors: MyTheme.of(context),
            suffixIcon: SvgPicture.asset(
              'assets/icon/arrow-right.svg',
              color: MyTheme.of(context).greyIconColor,
              width: 24,
              height: 24,
            )),
      ),
      onTap: () {
        showModalBottomSheet<void>(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kSheetBorderRadius),
                topRight: Radius.circular(kSheetBorderRadius),
              ),
            ),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9),
            context: context,
            builder: ((context) {
              return Stack(
                children: [
                  BlocProvider<RestorePasswordBloc>.value(
                    value: bloc,
                    child: const RestorePasswordRegionCompanyList(),
                  ),
                  const DragHandleWidget(),
                  const ModalBottomSheetIconBackWidget(),
                  const ModalSheetTitleWidget(),
                ],
              );
            }));
      },
    );
  }
}
