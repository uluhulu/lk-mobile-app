import '../../../core/utils/resources/use_case.dart';
import '../../repositories/user_repository.dart';

/// получение локального пина
class GetLocalAuthUseCase extends VoidUseCase<String?> {
  GetLocalAuthUseCase(
    this._userRepository,
  );
  final UserRepository _userRepository;

  @override
  String? call() {
    return _userRepository.getLocalAuthPin();
  }
}

/// установка локального пина
class SetLocalAuthUseCase extends FutureUseCase<void, String?> {
  final UserRepository _userRepository;

  SetLocalAuthUseCase(this._userRepository);

  @override
  Future<void> call(String? params) {
    return _userRepository.setLocalAuthPin(params);
  }
}
