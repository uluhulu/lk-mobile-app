import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/profile/profile_bloc/profile_bloc.dart';
import 'package:mkk/presentation/pages/profile/views/profile_data_card.dart';
import 'package:mkk/presentation/pages/profile/views/settings_card.dart';
import 'package:mkk/presentation/widgets/loading_page.dart';
import '../../../../services/error/bloc/error_bloc.dart';
import 'company_contact_card.dart';

class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: _createBloc,
      child: const ProfileContent(),
    );
  }

  ProfileBloc _createBloc(BuildContext context) {
    return ProfileBloc(
      repository: sl.get<Repository>(),
      errorBloc: context.read<ErrorBloc>(),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingS) {
          return const LoadingPage();
        } else if (state is ProfileLoadedS) {
          final profile = state.data.data;
          return ListView(
            padding: const EdgeInsets.only(top: kBasePadding * 2),
            children: [
              CompanyContactsCard(profile: profile),
              const Divider(height: 64, thickness: 2),
              ProfileDataCard(profile: profile),
              const SettingsCard()
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
