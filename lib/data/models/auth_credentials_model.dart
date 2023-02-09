import 'package:json_annotation/json_annotation.dart';

part 'auth_credentials_model.g.dart';

@JsonSerializable()
class AuthCredentialsModel {
  final String password;
  final String login;
  final int filial;
  final String token;
  final bool isLogin;

  AuthCredentialsModel({
    required this.password,
    required this.login,
    required this.filial,
    required this.token,
    required this.isLogin,
  });

  factory AuthCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCredentialsModelToJson(this);

  AuthCredentialsModel copyWith({
    String? password,
    String? login,
    int? filial,
    String? token,
    bool? isLogin,
  }) {
    return AuthCredentialsModel(
      password: password ?? this.password,
      login: login ?? this.login,
      filial: filial ?? this.filial,
      token: token ?? this.token,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
