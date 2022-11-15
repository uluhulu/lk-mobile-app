// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginException implements Exception {}

class RestorePasswordException implements Exception {}

class HttpValidateException implements Exception {
  final String message;
  HttpValidateException({
    required this.message,
  });
}
