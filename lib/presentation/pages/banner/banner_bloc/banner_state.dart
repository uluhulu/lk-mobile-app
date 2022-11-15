// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];

  String get stateName => 'BannerState';

  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
    };
  }

  factory BannerState.fromJson(Map<String, dynamic> json) {
    switch (json['stateName'] as String) {
      case 'BannerOkS':
        return BannerOkS.fromJson(json);
      case 'BannerShowS':
        return BannerShowS();

      default:
        return BannerOkS.fromJson(json);
    }
  }
}

class BannerOkS extends BannerState {
  final bool showSetPin;
  const BannerOkS({
    required this.showSetPin,
  });

  @override
  List<Object> get props => [showSetPin];

  factory BannerOkS.d() {
    return const BannerOkS(showSetPin: true);
  }

  @override
  String get stateName => 'BannerOkS';

  @override
  Map<String, dynamic> toJson() {
    return {
      'stateName': stateName,
      'showSetPin': showSetPin,
    };
  }

  factory BannerOkS.fromJson(Map<String, dynamic> json) {
    return BannerOkS(
      showSetPin: json['showSetPin'] as bool? ?? true,
    );
  }
}

class BannerShowS extends BannerState {}
