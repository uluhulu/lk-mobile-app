import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../restore_password_bloc/restore_password_bloc.dart';

class RestorePasswordRegionCompanyList extends StatelessWidget {
  const RestorePasswordRegionCompanyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
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
                    value: state.data.data[index].id,
                    groupValue: state.company.id,
                    onChanged: (value) {
                      context.read<RestorePasswordBloc>().add(
                          RestorePasswordToggleCompanyE(
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
