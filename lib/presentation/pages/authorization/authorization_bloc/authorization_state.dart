// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];

  String get stateName => 'AuthorizationState';

  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
    };
  }

  factory AuthorizationState.fromJson(Map<String, dynamic> json) {
    switch (json['stateName'] as String) {
      case 'AuthorizationSuccesS':
        return AuthorizationSuccesS();
      // case 'AuthorizationLocalAuthS':
      //   return AuthorizationLocalAuthS();
      case 'AuthorizationNeedLoginS':
        return AuthorizationNeedLoginS();
      case 'AuthorizationLocalSuccesS':
      case 'AuthorizationLocalNeedS':
        return AuthorizationLocalNeedS.fromJson(json);
      default:
        return AuthorizationNeedLoginS();
    }
  }
}

class AuthorizationLoadingS extends AuthorizationState {
  @override
  String get stateName => 'AuthorizationLoadingS';
}

class AuthorizationSuccesS extends AuthorizationState {
  @override
  String get stateName => 'AuthorizationSuccesS';
}

class AuthorizationNeedLoginS extends AuthorizationState {
  @override
  String get stateName => 'AuthorizationNeedLoginS';
}

class AuthorizationLocalSuccesS extends AuthorizationState {
  final String pinCode;
  final AuthorizationSuccesS data;
  const AuthorizationLocalSuccesS({
    required this.pinCode,
    required this.data,
  });
  @override
  String get stateName => 'AuthorizationLocalSuccesS';

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'pinCode': pinCode,
      'data': data.toJson(),
    };
  }

  factory AuthorizationLocalSuccesS.fromJson(Map<String, dynamic> json) {
    return AuthorizationLocalSuccesS(
      pinCode: json['pinCode'] as String,
      data: AuthorizationSuccesS(),
    );
  }
}

class AuthorizationLocalNeedS extends AuthorizationState {
  final String pinCode;
  final AuthorizationSuccesS data;
  const AuthorizationLocalNeedS({
    required this.pinCode,
    required this.data,
  });
  @override
  String get stateName => 'AuthorizationLocalNeedS';

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'pinCode': pinCode,
      'data': data.toJson(),
    };
  }

  factory AuthorizationLocalNeedS.fromJson(Map<String, dynamic> json) {
    return AuthorizationLocalNeedS(
      pinCode: json['pinCode'] as String,
      data: AuthorizationSuccesS(),
    );
  }
}
