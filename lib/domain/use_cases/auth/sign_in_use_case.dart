import 'package:injectable/injectable.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';

import '../../../core/utils/resources/use_case.dart';
import '../../repositories/user_repository.dart';

/// Авторизуем пользователя
@lazySingleton
class SignInUseCase extends FutureUseCase<bool, ProfileData> {
  SignInUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<bool> call(ProfileData profileData) async {
    if (getAccessToken() == null) {
      return false;
    }

    await _userRepository.setAccount(profileData);

    return true;
  }

  // Токен пользователя
  String? getAccessToken() {
    return _userRepository.getAccessToken();
  }
}
