import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/restore_password/views/restore_password_region_company_list.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../widgets/fields/custom_input_decoration.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../widgets/modal/modal_bottom_sheet_widget.dart';
import '../../authorization/widgets/modal_sheet_title_widget.dart';
import '../restore_password_bloc/restore_password_bloc.dart';

class RestorePasswordRegionCompanyField extends StatelessWidget {
  final RestorePasswordBloc bloc;

  const RestorePasswordRegionCompanyField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperValidationEnumBuilder<int>(
      superValidation: bloc.filialValidation,
      builder: (context, value) => SuperValidationTextFieldListener<int>(
        superValidation: bloc.filialValidation,
        transformer: (value) => bloc.getName(value ?? 0),
        readOnly: true,
        decoration: CustomInputDecoration(
            hintText: value == null
                ? S.of(context).not_selected
                : bloc.getName(value),
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
                BlocProvider<RestorePasswordBloc>.value(
                  value: bloc,
                  child: const RestorePasswordRegionCompanyList(),
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
