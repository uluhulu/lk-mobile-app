import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../restore_password_bloc/restore_password_bloc.dart';

class RestorePasswordRegionCompanyList extends StatelessWidget {
  const RestorePasswordRegionCompanyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RestorePasswordBloc>();
    return SuperValidationEnumBuilder(
      superValidation: bloc.filialValidation,
      builder: (context, value) =>
          BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
              builder: (context, state) {
        if (state is RestorePasswordLoadedS) {
          return Container(
            margin: const EdgeInsets.only(top: 64),
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      indent: kBasePadding,
                      endIndent: kBasePadding,
                    ),
                itemCount: state.data.data.length,
                itemBuilder: ((context, index) {
                  return RadioListTile(
                      visualDensity: VisualDensity.comfortable,
                      activeColor: MyTheme.of(context).primaryButtonColor,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: index,
                      groupValue: value,
                      onChanged: (newValue) {
                        bloc.filialValidation.value = newValue;
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                      title: Text(state.data.data[index].name));
                })),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
