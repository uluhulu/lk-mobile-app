import '../../domain/repositories/user_repository.dart';
import '../../locator/locator.dart';

extension DateTimeServer on DateTime {
  DateTime get server {
    final offset = sl<UserRepository>().getLocalTimeOffset();
    return add(offset);
  }
}
