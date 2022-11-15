// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'local_auth_bloc.dart';

abstract class LocalAuthState extends Equatable {
  const LocalAuthState();

  @override
  List<Object> get props => [];

  String get stateName => 'LocalAuthState';

  Map<String, dynamic> toJson() => {
        'stateName': stateName,
      };
  factory LocalAuthState.fromJson(Map<String, dynamic> json) {
    switch (json['stateName'] as String) {
      case 'LocalAuthInitialS':
        return LocalAuthInitialS();
      case 'LocalAuthPinS':
        return LocalAuthPinS.fromJson(json);

      default:
        return LocalAuthInitialS();
    }
  }
}

class LocalAuthInitialS extends LocalAuthState {
  @override
  String get stateName => 'LocalAuthInitialS';
}

class LocalAuthPinS extends LocalAuthState {
  // final PinCodeViewEntity data;
  final String pin;
  const LocalAuthPinS({
    //  required this.data,
    required this.pin,
  });

  @override
  List<Object> get props => [pin];

  @override
  String get stateName => 'LocalAuthPinS';

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'pin': pin,
    };
  }

  factory LocalAuthPinS.fromJson(Map<String, dynamic> json) {
    return LocalAuthPinS(pin: json['pin']);
  }
}

class LocalAuthSuccessS extends LocalAuthState {
  final String pin;
  const LocalAuthSuccessS({
    required this.pin,
  });
  @override
  String get stateName => 'LocalAuthPinS';

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'pin': pin,
    };
  }

  @override
  List<Object> get props => [pin];
}

class LocalAuthReEnterS extends LocalAuthState {
  final String pin;
  const LocalAuthReEnterS({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

//reenter pin
class LocalAuthEnteredS extends LocalAuthState {
  final String pin;
  const LocalAuthEnteredS({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

class LocalAuthLoadingS extends LocalAuthState {}

class LocalAuthInitializedS extends LocalAuthState {}

class LocalAuthLocalPinErrorS extends LocalAuthState {}
