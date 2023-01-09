import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/authorization/widgets/region_company_list.dart';
import 'package:super_validation/enum_builder.dart';
import 'package:super_validation/text_field_listener.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../widgets/modal/modal_bottom_sheet_widget.dart';
import '../../login_bloc/login_bloc.dart';
import '../modal_sheet_title_widget.dart';

class FilialTextField extends StatelessWidget {
  const FilialTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return SuperValidationEnumBuilder<int>(
      superValidation: loginBloc.filialValidation,
      builder: (context, value) => SuperValidationTextFieldListener<int>(
        superValidation: loginBloc.filialValidation,
        altValidation: loginBloc.filialValid,
        autovalidateMode: AutovalidateMode.always,
        transformer: (value) => loginBloc.getName(value ?? 0),
        readOnly: true,
        decoration: CustomInputDecoration(
            hintText: value == null ? 'Не выбрано' : loginBloc.getName(value),
            hintStyle: value == null
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
        onTap: () {
          BaseBottomSheetWidget(
            context: context,
            child: Stack(
              children: [
                BlocProvider<LoginBloc>.value(
                  value: loginBloc,
                  child: const RegionCompanyList(),
                ),
                const DragHandleWidget(),
                const ModalBottomSheetIconBackWidget(),
                const ModalSheetTitleWidget(),
              ],
            ),
          ).show();
        },
      ),
    );
  }
}
