import '../../../core/utils/resources/use_case.dart';
import '../../repositories/repository.dart';
import '../../repositories/user_repository.dart';

/// Выход пользователя
class LogOutUseCase extends FutureUseCase<void, void> {
  LogOutUseCase(
    this._repository,
    this._userRepository,
  );

  final Repository _repository;
  final UserRepository _userRepository;

  @override
  Future<void> call([void params]) async {
    final String? accessToken = _userRepository.getAccessToken();

    await Future.wait(<Future<void>>[
      if (accessToken != null) _repository.logout(),
      _userRepository.logOut(),
    ]);
  }
}
