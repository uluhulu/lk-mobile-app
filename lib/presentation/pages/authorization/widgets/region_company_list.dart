import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../login_bloc/login_bloc.dart';

class RegionCompanyList extends StatelessWidget {
  const RegionCompanyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoadedS) {
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
                    value: state.data.data[index].id,
                    groupValue: state.company.id,
                    onChanged: (value) {
                      context.read<LoginBloc>().add(LoginEventToggleCompanyE(
                          company: state.data.data[index]));
                      Navigator.of(context).pop();
                    },
                    title: Text(state.data.data[index].name));
              })),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
