// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../api/claim_drafts/send/entity/claim_drafts_send_error_entity.dart';

class LoginException implements Exception {}

class RestorePasswordException implements Exception {}

class HttpValidateException implements Exception {
  final String message;
  HttpValidateException({
    required this.message,
  });
}

class ClaimDraftsSendException implements Exception {
  final ClaimDraftsSendErrorEntity errors;
  ClaimDraftsSendException({
    required this.errors,
  });
}
