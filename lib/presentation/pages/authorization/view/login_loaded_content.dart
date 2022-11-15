// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../../widgets/fields/custom_input_decoration.dart';
import '../../../widgets/modal/modal_bottom_sheet_widget.dart';
import '../authorization_bloc/authorization_bloc.dart';
import '../login_bloc/login_bloc.dart';
import '../widgets/login_text_field.dart';
import '../widgets/modal_register_info_widget.dart';
import '../widgets/modal_sheet_title_widget.dart';
import '../widgets/password_text_field.dart';
import '../widgets/region_company_list.dart';
import '../widgets/restore_password_button.dart';

class LoginLoadedContent extends StatelessWidget {
  final int companyId;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final LoginLoadedS state;
  const LoginLoadedContent({
    Key? key,
    required this.companyId,
    required this.loginController,
    required this.passwordController,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return SingleChildScrollView(
      //physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(kBasePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/auth_logo.svg',
                  width: 141,
                  height: 31,
                ),
              ),
              const Spacer(flex: 4),
              Text(
                S.of(context).login,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              LoginTextField(
                controller: loginController,
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).password,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              PasswordTextField(
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12),
              const RestorePasswordButton(),
              const SizedBox(height: 24),
              Text(
                S.of(context).region_company,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              _regionCompanyField(companyId, context, loginBloc),
              const SizedBox(height: 32),
              PrimaryElevatedButton(
                onPressed: () {
                  context.read<AuthorizationBloc>().add(AuthorizationLoginE(
                        filial: companyId,
                        login: loginController.text,
                        password: passwordController.text,
                      ));
                },
                text: S.of(context).enter,
              ),
              const Spacer(flex: 4),
              const Center(
                child: ModalRegisterInfoWidget(),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _regionCompanyField(
      int companyId, BuildContext context, LoginBloc loginBloc) {
    return InkWell(
      child: TextField(
        enabled: false,
        //TODO: очень плохая реализация, нужно переделать
        decoration: CustomInputDecoration(
            hintText: companyId == 2 ? 'Не выбрано' : state.company.name,
            hintStyle: companyId == 2
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
                  BlocProvider<LoginBloc>.value(
                    value: loginBloc,
                    child: const RegionCompanyList(),
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
