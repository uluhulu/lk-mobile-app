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
        return AuthorizationSuccesS.fromJson(json);
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
  final String token;
  final bool isLogin;

  const AuthorizationSuccesS({
    required this.token,
    required this.isLogin,
  });
  @override
  String get stateName => 'AuthorizationSuccesS';

  @override
  factory AuthorizationSuccesS.fromJson(Map<String, dynamic> json) {
    return AuthorizationSuccesS(
      token: json['token'] as String,
      isLogin: json['isLogin'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'token': token,
      'isLogin': isLogin,
    };
  }
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
      data: AuthorizationSuccesS.fromJson(json['data'] as Map<String, dynamic>),
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
      data: AuthorizationSuccesS.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
