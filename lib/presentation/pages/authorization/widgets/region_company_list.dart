import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../login_bloc/login_bloc.dart';

class RegionCompanyList extends StatelessWidget {
  const RegionCompanyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return SuperValidationEnumBuilder(
      superValidation: bloc.filialValidation,
      builder: (context, value) =>
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoadedS) {
          return Container(
            margin: const EdgeInsets.only(top: 74),
            child: ListView.separated(
                separatorBuilder: _separator,
                itemCount: state.data.data.length,
                itemBuilder: ((context, index) {
                  return RadioListTile<int>(
                      visualDensity: VisualDensity.comfortable,
                      activeColor: MyTheme.of(context).primaryButtonColor,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: state.data.data[index].id,
                      groupValue: value,
                      onChanged: (newValue) {
                        bloc.filialValidation.value = newValue;
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                      title: Text(bloc.getName(index)));
                })),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _separator(BuildContext context, int index) {
    return const Divider(
      indent: kBasePadding,
      endIndent: kBasePadding,
    );
  }
}
