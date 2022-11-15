import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';

import '../../../core/utils/resources/use_case.dart';
import '../../repositories/user_repository.dart';

/// Вход пользователя
class LogInUseCase extends FutureUseCase<void, AuthData> {
  LogInUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<void> call(AuthData authData) async {
    await Future.wait(<Future<void>>[
      _userRepository.setAuh(authData),
    ]);
  }
}
